class ItemsController < ApplicationController

  layout 'main'

  before_filter :find_item, only: [:show, :edit, :update, :destroy, :upvote, :crop_image]
  #before_filter :check_if_admin, only: [:edit, :update, :new,:create, :destroy]
  #before_filter :authenticate_user!, except: [:show, :index]

  #attr_accessor :crop_x, :crop_y, :crop_w, :crop_h


  def index
    @items = Item
    @items  = @items.where("price >= ?", params[:price_from]) if params[:price_from]
    @items = @items.where("created_at >= ?", 2.day.ago)  if params[:today]
    @items = @items.where("votes_count >= ?", params[:votes_from]) if params[:votes_from]
    @items  = @items.order("votes_count DESC", "price")
    @items = @items.includes(:images)
    #@items = Item.all(order: :name)
    #@items = Item.all.order("votes_count DESC", "price").limit(50)
    #  @items = Item.all
    #  render text: @items.map {|i| "#{i.name}: #{i.price}"}.join("<br/>")
  end

  #CRUD
  # /items POST
  def create

    @item = Item.create(item_params)
    if @item.errors.empty?
      render :crop_image
      #redirect_to crop_image_item_path(@item) #item_path(@item)       # /items/:id
    else
      @item.images.build
      render "new"
    end
    #render text: params.inspect
    ##p params
    ##@item = Item.create(name: params[:name], description: params[:description], price: params[:price], real: params[:real], weight: params[:weight])
    #item_params = params.require(:item).permit(:name, :description, :price, :weight, :real)
    #@item = Item.create(item_params)
    ##@item = Item.create(params[:item])
    #p params
    #render text: "#{@item.id}: #{@item.name} (#{!@item.new_record?})"   #"item created"
  end

  # /items/1 GET
  def show
    unless @item #= Item.where(id: params[:id]).first
      render text: "Page not found", status: 404
    end
  end

  # /items/new GET
  def new

    @item = Item.new
    @item.images.build
  end
  # /items/1/edit GET
  def edit
    #@item = Item.find(params[:id])
  end

  # /items/1 PUT через POST
  def update
    if params[:item]
      @item.update_attributes(item_params)
      if @item.errors.empty?
        flash[:success] = "Item successfully updated"
        render :crop_image
        #redirect_to crop_image_item_path(@item)  #item_path(@item)       # /items/:id
      else
        flash.now[:error] = "You made mistakes in your form! Please correct them."
        render "edit"
      end
    end
  end

  # /items/1 DELETE через POST
  def destroy
    #@item = Item.find(params[:id])
    @item.destroy
    redirect_to action: "index"    #item_path
  end

  def upvote
    @item.increment!(:votes_count)
    redirect_to action: "index"
  end

  def expensive
    #@items = Item.where("price > 1000")
    @items = Item.where("price >= ?",params[:price_from])      #NO SQL Injections
    #@items = Item.where("price >= #{params[:price_from]}")      #SQL Injections
    #@items = Item.where("price = 5000 OR votes_count = 5")
    #@items = Item.where(price: 5000, votes_count: 5)
    #@items = Item.where(votes_count: 5)
    render "index"
  end

  private
  def item_params
    params.require(:item).permit!#(:name, :description, :price, :weight, :real, image: [])
    #params.require(:item).permit!#(:name, :description, :price, :weight, :real, :images_attributes => [:"0" => [:image =>[]]])
    #params.require(:item).permit(:name, :description, :price, :weight, :real, :file)#:images_attributes => {image:[]})
  end

  def find_item
    @item = Item.where(id: params[:id]).first
    #@item = Item.find(params[:id])
    render_404 unless @item
  end

end
