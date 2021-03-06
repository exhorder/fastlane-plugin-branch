describe Fastlane::Actions::SetupBranchAction do
  let (:action) { Fastlane::Actions::SetupBranchAction }
  let (:command) { BranchIOCLI::Command::SetupCommand }

  it 'provides the same options as the SetupCommand' do
    expect(action.available_options.map(&:key).sort).to eq command.available_options.map(&:name).sort
  end

  it 'loads the Branchfile and calls run!' do
    mock_config = double :configuration
    expect(mock_config).to receive(:load_configuration_file).with("Branchfile")

    mock_command = double :command
    expect(mock_command).to receive(:run!)

    expect(command).to receive(:new) { mock_command }

    action.run(mock_config)
  end

  it 'calls UI.user_error! on exception' do
    mock_config = double :configuration
    expect(mock_config).to receive(:load_configuration_file).with("Branchfile")

    mock_command = double :command
    expect(mock_command).to receive(:run!).and_raise(RuntimeError)

    expect(command).to receive(:new) { mock_command }

    expect(FastlaneCore::UI).to receive(:user_error!)

    action.run(mock_config)
  end

  it 'is supported on iOS' do
    expect(action.is_supported?(:ios)).to be true
  end

  it 'is in the :project category' do
    expect(action.category).to eq :project
  end

  it 'renders the description template for details' do
    expect(action).to receive(:render).with(:setup_description) { "rendered description" }
    expect(action.details).to eq "rendered description"
  end

  it 'has a description' do
    expect(action.description).not_to be_blank
  end

  it 'has authors' do
    expect(action.authors).not_to be_blank
  end

  it 'has examples' do
    expect(action.example_code).not_to be_blank
  end
end
