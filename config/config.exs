use Mix.Config

if Mix.env() == :test do
  config :module_config, ModuleConfigTest,
    value_1: :a,
    value_2: :b
end
