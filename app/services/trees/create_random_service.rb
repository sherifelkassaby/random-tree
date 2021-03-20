# This service, is responsible of creating random trees and not expecting any input.
# it uses the "Path Enumeration" pattern to store the info about the tree.
module Trees
  class CreateRandomService
    include ServiceLoader

    def run
      generator_result = Tree::RandomGeneratorGateway.generate_random_tree
      return generator_err_resp unless generator_result.success?

      random_tree = generator_result.tree.with_indifferent_access
      return invaild_tree_structure_resp if invaild_tree_structure?(random_tree)

      create_tree(random_tree)

      tree_hash = Trees::PopulateTreeNodesService.run(nodes_list: @nodes_list)

      OpenStruct.new(sucess?: true, msg: 'Created successfully.', tree_hash: tree_hash)
    end

    private

    def create_tree(tree_hash)
      @tree_id = tree_hash['id']
      @nodes_list = []
      create_node(node_id: @tree_id)

      create_childs(childs_arr: tree_hash['child'], parent_path: tree_hash['id'].to_s + '/')
    end

    def create_node(node_id:, parent_path: '')
      current_path = parent_path + node_id.to_s + '/'

      @nodes_list << Node.create(node_id: node_id, path: current_path, tree_id: @tree_id)
    end

    def create_childs(childs_arr:, parent_path:)
      childs_arr.map do |node_hash|
        create_node(node_id: node_hash['id'], parent_path: parent_path)
        create_childs(childs_arr: node_hash['child'], parent_path: parent_path + node_hash['id'].to_s + '/')
      end
    end

    def invaild_tree_structure?(random_tree)
      return true unless random_tree.present?
      return true unless random_tree[:id]
      return true unless random_tree[:child]

      false
    end

    def invaild_tree_structure_resp
      msg = 'could not create tree, invaild tree structure.'

      OpenStruct.new(success?: false, msg: msg)
    end

    def generator_err_resp
      msg = 'could not create tree, Generator error.'

      OpenStruct.new(success?: false, msg: msg)
    end
  end
end
