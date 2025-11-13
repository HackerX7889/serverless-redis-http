defmodule Srh.MixProject do
  use Mix.Project

  def project do
    [
      app: :srh,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      config_path: "config/config.exs",
      deps: deps(),
      releases: releases()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Srh, []}
    ]
  end

  defp deps do
    [
      {:redix, "~> 1.1"},
      {:castore, ">= 0.0.0"},
      {:plug, "~> 1.13"},
      {:cowboy, "~> 2.12"},  # Updated to 2.12 for OTP 27/28 compatibility
      {:plug_cowboy, "~> 2.7"},  # Updated
      {:jason, "~> 1.4"},
      {:gen_registry, "~> 1.1"},
      {:burrito, github: "burrito-elixir/burrito"}
    ]
  end

  defp releases do
    [
      srh: [
        steps: [:assemble, &Burrito.wrap/1],
        burrito: [
          targets: [
            linux_x64: [os: :linux, cpu: :x86_64],
            linux_arm64: [os: :linux, cpu: :aarch64],
            macos_x64: [os: :darwin, cpu: :x86_64],
            macos_arm64: [os: :darwin, cpu: :aarch64],
            windows_x64: [os: :windows, cpu: :x86_64]
          ]
        ]
      ]
    ]
  end
end
