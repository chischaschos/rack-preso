require 'lib/walking_arrow.rb'
RailsRackApp::Application.routes.draw do
  get 'home/index'
  get 'walkingarrow' => WalkingArrow.new
end
