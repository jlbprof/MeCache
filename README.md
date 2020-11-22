# MeCache

I wrote this program because I needed/wanted it.   I work on one set of
computers, and have a bunch of computers I work on at home.  I am constantly
wanting to pass data back and forth between my work computers and home
computers (I do not pass proprietary data).  Mostly I pass bookmarks and small
snippets of code, or text, and of course the occaisonal file.   I have a mix
of programs that help me out on this, but they have limitations because I am
too cheap to fork out bucks for doing this.   Most notably Dropbox TM.  It is
awesome, but I am limited with a free account how much data and how many
computers I can hook up to it.  I have a cross browser/computer bookmark
syncing program, which is free.

Because of needing multiple programs some with limitations that are
problematic for me, I wrote Mecach.  Or more specifically My Cache of stuff.

## It is written in Perl

And as a result the client at least should run on all systems, Linux, MacOS
and using WSL on Windows or Strawberry Perl.

## What I have now

What I have now is a set of Moo classes and a client script.   Currently it
only stores the data locally, in 2 locations "master" which should really be
renamed "ephemeral" where whatever is stored there will be removed
automatically after a configured period of time.   Or in "pinned" where the
objects remain indefinitely.

In the long run I want to allow heirachial organization of the "pinned"
objects so that they will be easier to find.

    julian@DESKTOP-FC2E2Q8:~/mecache$ tree .
    .
    ├── LICENSE
    ├── MeCache
    │   ├── Bookmark.pm
    │   ├── Dir.pm
    │   ├── File.pm
    │   ├── Init.pm
    │   ├── Message.pm
    │   └── Meta.pm
    ├── README.md
    ├── create_mecache_file.pl
    ├── master
    │   ├── 1603333177_53858_987768.meta
    │   ├── 1603492143_55555_66666.meta
    │   ├── 1603492166_55557_66668.meta
    │   ├── 1603492177_55558_66668.meta
    │   ├── 1603494177_66558_16668.meta
    │   ├── 1606003007_1697_880286548.meta
    │   ├── 1606003046_1699_239573126.meta
    │   └── 1606003107_1707_581543134.meta
    ├── master_summary.pl
    ├── mecache
    ├── output.txt
    ├── pinned
    │   └── 1603492155_55556_66667.meta
    ├── review_clones.pl
    └── save
        └── 1603492155_55556_66667.meta

    4 directories, 23 files

