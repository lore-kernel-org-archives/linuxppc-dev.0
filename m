Date: Sun, 09 Apr 2000 12:44:26 -0700
From: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>
Subject: Remaining Pismo issues
To: LinuxPPC <linuxppc-dev@lists.linuxppc.org>
Message-id: <38F0DD9A.E5DA1AEB@dana.ucc.nau.edu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm sure you're all getting tired of hearing from me, but this should be
one of the last times I need to write here.  I've managed to get
LinuxPPC 2000 installed and running correctly on my Pismo, and I have
just a couple of remaining issues to resolve.  This is not user-end
stuff, but mostly internal problems.  Here we go:

-  Power management in Linux is not so good.  In comparison with the
MacOS (bad comparison, I know), the battery on my Pismo seems to last
about an hour less.  If I understand correctly, Apple used a new kind of
PMU in the new laptops.  Is this correct, and if so, how well is the new
chip supported?

- Somewhat related to power management problem, the laptop gets much
hotter when using Linux.  The internal fan runs almost constantly.
Plus, the computer will often hit the shutdown point of the
motherboard.  This causes the operating system to freeze, because the
computer can't operate at such high temperatures.  Has anyone seen this
problem before and found a way around it?

- I had tried to run KDE on my machine using the kdm login manager.  For
some reason, this would not work correctly, and X kept returning the
error "stdin: is not a tty".  I switched back over to the gdm login
manager, and everything seems to work ok.

That's all I've noticed recently.  Thanks for any help you can provide.

Tim


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
