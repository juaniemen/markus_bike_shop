class BikeOrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bike_order, only: %i[ show edit update destroy ]

  # GET /bike_orders or /bike_orders.json
  def index
    @bike_orders = BikeOrder.all.where(user_id: current_user.id)
  end

  # GET /bike_orders/1 or /bike_orders/1.json
  def show
  end

  # GET /bike_orders/new
  def new
    @bike_order = BikeOrder.new
    build_bike_order_items  
  end

  # GET /bike_orders/1/edit
  def edit
    build_bike_order_items
  end

  # POST /bike_orders or /bike_orders.json
  def create
    @bike_order = BikeOrder.new(bike_order_params)
    @bike_order.user = current_user
    build_bike_order_items
    @bike_order.calculate_bike_order_prices!

    respond_to do |format|
      if @bike_order.save
        format.html { redirect_to @bike_order, notice: "Bike order was successfully created." }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /bike_orders/1 or /bike_orders/1.json
  def update
    build_bike_order_items
    @bike_order.calculate_bike_order_prices!
    respond_to do |format|
      if @bike_order.update(bike_order_params)
        format.html { redirect_to @bike_order, notice: "Bike order was successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /bike_orders/1 or /bike_orders/1.json
  def destroy
    @bike_order.destroy!

    respond_to do |format|
      format.html { redirect_to bike_orders_path, status: :see_other, notice: "Bike order was successfully destroyed." }
    end
  end

  # POST /bike_orders/check_bike_order.js
  def check_bike_order
    @bike_order = BikeOrder.new(bike_order_params)
    @bike_order.calculate_bike_order_prices!
    
    respond_to do |format|
      format.js { render layout: false }
    end
 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bike_order
      @bike_order = BikeOrder.includes(bike_order_items: :component).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bike_order_params
      params.require(:bike_order).permit(:id, :observations, bike_order_items_attributes: [:id, :component_id])
    end

    def build_bike_order_items
      if @bike_order.bike_order_items.empty?
        Component.component_types.each {|c_type| @bike_order.bike_order_items.build(ctype: c_type) }
      else
        present_ctypes = []
        @bike_order.bike_order_items.each{ |m| m.ctype= m.component&.c_type; (present_ctypes << m.ctype if m.ctype.present?) }
        absent_ctypes = Component.component_types - present_ctypes
        @bike_order.bike_order_items.select{|m| m.ctype.nil?}.zip(absent_ctypes).each do |boi, ac|
          boi.ctype=ac
        end
      end
    end
end
