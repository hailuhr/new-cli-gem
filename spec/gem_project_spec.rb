require 'spec_helper'

describe GemProject do
  it 'has a version number' do
    expect(GemProject::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end
