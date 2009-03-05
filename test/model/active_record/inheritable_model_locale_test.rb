require File.join(File.dirname(__FILE__), '../../test_helper')

require 'activerecord'
require 'globalize/model/active_record'
ActiveRecord::Base.send(:include, Globalize::Model::ActiveRecord::Translated)

require File.join(File.dirname(__FILE__), '../../data/post')

class InheritableModelLocaleTest < ActiveSupport::TestCase
  
  def setup
    reset_db! File.expand_path(File.join(File.dirname(__FILE__), '../../data/schema.rb'))
  end
  
  def test_inheritable_model_locale
    Post.locale = :en
    post = Post.create(:subject => 'subject')
    
    assert_equal post.subject, 'subject'

    # creating a blog written in spanish
    Blog.locale = :en
    blog = Blog.create(:description => 'my first blog')
    
    assert_equal blog.description, 'my first blog'
    Blog.locale = :es
    blog.description = 'mi primer blog'
    
    assert_equal('mi primer blog', blog.description)
    
    # the post subject should still be the english 
    assert_equal('subject', post.subject)
  end
  
end