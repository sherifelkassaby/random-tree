class Api::V1::NodesController < Api::V1::ApiBaseController
  before_action :set_node, only: [:find_parent, :find_childs]

  def index
    result = Trees::CreateRandomService.run

    if result.sucess?
      render json: response_success(result.msg, result.tree_hash), status: :created
    else
      render json: response_fail(result.msg), status: :unprocessable_entity
    end
  end

  def find_parent
    parent_hash = @node.parent_hash

    if parent_hash
      render json: response_success('Parent is found successfully.', parent_hash), status: :created
    else
      render json: response_fail('Could not find a parent.'), status: :unprocessable_entity
    end
  end

  def find_childs
    childs_hash = @node.childs_hash

    if childs_hash
      render json: response_success('Childs are found successfully.', childs_hash), status: :created
    else
      render json: response_fail('Could not find  childs.'), status: :unprocessable_entity
    end
  end


  private

  def set_node
    @node = Node.find_by_node_id(params[:id])
  end
end
