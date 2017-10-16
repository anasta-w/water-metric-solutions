class LocationsController < ApplicationController

  before_action :load_locationable

  def new
    @locationable = @locationable.location.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def delete
  end

  private

  def load_locationable
    resource, id = request.path.split('/')[1,2]
    @alertable = resource.singularize.classify.constantize.find(id)
  end
end
