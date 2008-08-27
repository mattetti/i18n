require "rubygems"
require "rbench"
$:.unshift "./../lib"
require File.dirname(__FILE__) + '/../lib/i18n'
require 'time'

TIMES = 100_000

RBench.run(TIMES) do
  
  column :times
  column :one,  :title => "simple backend using #translate"
  column :two,  :title => "Ruby hash"
  column :diff, :title => "#1/#2", :compare => [:one,:two]

  report "lookup with locale given" do
    @backend = I18n::Backend::Simple.new
    @backend.store_translations 'en-US', :foo => {:bar => 'bar', :baz => 'baz'}
    @memory_hash = {:'en-US' => {:foo => {:bar => 'bar', :baz => 'baz'}} }
    
    one { @backend.translate('en-US', :bar, :scope => [:foo]) }
    two { @memory_hash[:'en-US'][:foo][:bar] }
  end

end

RBench.run(TIMES) do
  
  column :times
  column :one,  :title => "no key"
  column :two,  :title => "key with scope"
  column :three, :title => "hash key being nil"
  column :diff, :title => "#1/#3", :compare => [:one,:three]
  
  report "lookup with no key given" do
    @backend = I18n::Backend::Simple.new
    @backend.store_translations 'en-US', :foo => {:bar => 'bar', :baz => 'baz'}
    @memory_hash = {:'en-US' => {:foo => {:bar => 'bar', :baz => 'baz'}} }
    
    one   { @backend.translate('en-US', nil, :default => 'default') }
    two   { @backend.translate('en-US', :bar, :scope => [:foo]) }
    three { @memory_hash[:test] }
  end

end