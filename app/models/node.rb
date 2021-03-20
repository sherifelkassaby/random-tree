class Node < ApplicationRecord

  def parent_hash
    return if self.path.split('/').size < 2

    parent_node_id = self.path.split('/')[-2]

    { id: parent_node_id }
  end

  def childs_hash
    # getting all nodes which is starting with a samiliar path.
    nodes_list = Node.where('path like ?', self.path + '%').and(Node.where.not(id: self.id))
    return if nodes_list.empty?

    # excluding grand children's
    childs_list = nodes_list.select{ |node| node.depth == self.depth + 1}
    childs_hash = childs_list.map { |node| { id: node.node_id, path: node.path } }

    { id: self.node_id, childs: [childs_hash]}
  end

  def depth
    self.path.split('/').size
  end
end
