# This is an example of a Sombrero DSL script. In this example we are trying
# to control states on a jukebox. This file goes in the config directory.

Workflow::Rules::Checker.instance.add_rules do
  # Rules for CD player
  # ---------------------------------------------------------------------------
  pause :cd_player, :unless => lambda { |r| r.paused? || r.stopped? }
  play  :cd_player, :unless => lambda { |r| r.playing? || r.empty? }

  # Rules for the Jukebox itself
  # ---------------------------------------------------------------------------
  stop    :jukebox, :if     => Jukebox::PLAYING
  play    :jukebox, :if     => lambda { |jk| jk.available_credits? }, 
                    :and    => lambda { |jk| !jk.playing? }
  pause   :jukebox, :if     => lambda { |jk| jk.playing? },
                    :unless => lambda { |jk| jk.cannot_be_paused? }
  display :jukebox
end
