Date: Fri, 05 Nov 1999 01:36:35 -0600
Subject: 2.2.13 vger kernel panic on iMac - whoa.
From: Geoffrey Pursell <purs0007@tc.umn.edu>
To: <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B447E523.775%purs0007@tc.umn.edu>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I wonder if anyone else has had the same problems I've had with recent
kernels.

I'm running LinuxPPC 1999 Q3 w/ BootX 1.1.3 on a Rev. C iMac.  I've been
looking for a more recent kernel than the included 2.2.6 so I can have a
shot at trying Mac-on-Linux.  What I ended up doing was checking out the
linux_2_2 branch of the vger tree and patching it with the 2.2.13 vger patch
that comes with MoL, since run-time patching didn't seem to work with any
kernel I tried.  The source patched fine, though.

I configured everything as I thought it should be (actually, more or less as
suggested on imaclinux.net), and everything compiled okay, but I've got two
problems.

1)  I don't see the USB mouse/keyboard drivers I supposedly compiled in
showing up anywhere.  Ever.  Do I still need a patch for USB, or what?

And slightly more disturbing,

2)  I get a kernel panic on startup right after it figures out that I've got
a Rage Pro 3D.  I think that's what it finds, anyway...I'd have to go back
and look to be sure.

Strangely enough, many of the prebuilt kernels in the /imaclinux directory
on yellowdog's ftp server cause the same kernel panic.  Does anyone have a
clue what's going wrong here?

Thanks!

- Geoff


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
