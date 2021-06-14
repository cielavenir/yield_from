require File.expand_path(File.dirname(__FILE__)+'/spec_helper')

def rec(n)
	return to_enum(:rec,n) if !block_given?
	return if n<0
	yield n
	yield *rec(n-1)
end
yield_from :rec

describe 'local function' do
	it 'yields recursively' do
		rec(5).to_a.should eq [5,4,3,2,1,0]
	end
end

class A
	extend YieldFrom
	def rec1(n)
		return to_enum(:rec1,n) if !block_given?
		return if n<=0
		yield n
		yield *rec2(n-1)
	end
	def rec2(n)
		return to_enum(:rec2,n) if !block_given?
		return if n<=0
		yield n
		yield *rec1(n/2)
	end
	yield_from :rec1, :rec2
end

describe 'instance method' do
	it 'yields recursively' do
		A.new.rec1(7).to_a.should eq [7,6,3,2,1]
	end
end

H=Hash.new{|h,k|h[k]=[]}
n=10
root=1
roots=[*1..n]
2.upto(n){|i|
	H[i/2] << i
}
def preorder(node)
	return to_enum(:preorder,node) if !block_given?
	yield node
	H[node].each{|e|yield *preorder(e) if e!=-1}
end
def inorder(node)
	return to_enum(:inorder,node) if !block_given?
	children=H[node]
	yield *inorder(children[0]) if children[0]&&children[0]!=-1
	yield node
	yield *inorder(children[1]) if children[1]&&children[1]!=-1
end
def postorder(node)
	return to_enum(:postorder,node) if !block_given?
	H[node].each{|e|yield *postorder(e) if e!=-1}
	yield node
end
yield_from :preorder, :inorder, :postorder

describe 'complex case' do
	specify 'preorder' do
		preorder(root).to_a.should eq [1, 2, 4, 8, 9, 5, 10, 3, 6, 7]
	end
	specify 'inorder' do
		inorder(root).to_a.should eq [8, 4, 9, 2, 10, 5, 1, 6, 3, 7]
	end
	specify 'postorder' do
		postorder(root).to_a.should eq [8, 9, 4, 10, 5, 2, 6, 7, 3, 1]
	end
end

