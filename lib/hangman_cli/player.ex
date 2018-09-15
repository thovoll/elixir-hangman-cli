defmodule HangmanCli.Player do
  alias HangmanCli.{Mover, Prompter, State, Summary}

  def play(state = %State{}) do
    case state.tally.game_state do
      :won -> exit_with_message("#{word(state)}! You WIN!")
      :lost -> exit_with_message("Sorry, you lost (the word was: #{word(state)})")
      :good_guess -> continue_with_message(state, "Good guess!")
      :bad_guess -> continue_with_message(state, "Sorry, that isn't in the word")
      :already_used -> continue_with_message(state, "You've already used that letter")
      _ -> continue(state)
    end
  end

  def continue(state = %State{}) do
    state
    |> Summary.display!()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end

  def continue_with_message(state = %State{}, msg) do
    IO.puts(msg)
    continue(state)
  end

  defp exit_with_message(msg) do
    IO.puts(msg)
    exit(:normal)
  end

  defp word(state = %State{}) do
    Enum.join(state.game_service.letters)
  end
end
