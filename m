Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Date: Tue, 25 Nov 2003 16:51:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: MPC5xxx updates
Message-ID: <20031125235150.GC2541@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've done a number of small changes since the last commit, and thus
rebuilt the repo.  Please rm any copies you have and start over like I
described in the first e-mail about this repo.
- Mark mpc5xxx_set_bat as __init
- Remove 'port by' printks (Paul doesn't like agree with the.  Wolfgang,
  I've added DENX to the top of platforms/icecube.c, is this OK?).
- Style things (don't #if out includes or externs, C99 struct
  declarations).
- Correct some dependencies in the code (IDE_MPC5xxx already depends on
  IDE being set).
- Audit MTD map file for MB/KB (change to MiB/KiB per the preference of
  upstream MTD).

>From Wolfgang:
- Add GPL boilerplate to a number of files.

>From Dale:
- Remove Bestcomm files we don't care about.

Now based on the comments from Paul, Christoph and Ben, I think what we
should do is try and clean up the code as best as possible to have a
good patch for people that need the code to start from.  Is this
agreeable?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
