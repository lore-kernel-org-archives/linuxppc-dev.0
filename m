To: linuxppc-dev@lists.linuxppc.org
Subject: USB audio
From: Lars Brinkhoff <lars@nocrew.org>
Date: 21 Feb 2002 16:24:06 +0100
Message-ID: <85ofii3lk9.fsf@junk.nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I got an iSub today.  It's recognized as an USB audio device when it's
connected, and it basically works, but there are two problems:

* Whenever I kill a process (with ^C, to be precise) writing audio
  data to the iSub, that process hangs.  From then on, all processes
  opening the dsp or mixer devices also hang.  If I don't kill the
  process, suspending and resuming works fine.

* The "aumix" program (version 2.7) doesn't seem to think there is a
  volume control.

I'm running Linux 2.4.18-rc1-benh (from ppckernel.org).

--
Lars Brinkhoff          http://lars.nocrew.org/     Linux, GCC, PDP-10,
Brinkhoff Consulting    http://www.brinkhoff.se/    HTTP programming

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
