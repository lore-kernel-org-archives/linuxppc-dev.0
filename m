Date: Thu, 25 Mar 2004 15:12:15 +0100 (CET)
To: linuxppc-dev@lists.linuxppc.org, benh@kernel.crashing.org
Subject: Zilog driver - auto-detect for no oopsen
Message-ID: <Pine.LNX.4.58.0403251503060.7074@rosencrantz.theboonies.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
From: David Eger <eger@theboonies.us>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I recently compiled  Linux Kernel v2.6.5-rc2-ben0 and...

Is there any auto-detection code we can add to the Zilog driver?

I accidentally enabled the  CONFIG_SERIAL_PMACZILOG option for my kernel,
and it crashes my powerbook all to hell when i try to put it to sleep...
I know the option is irrelevant for my hardware, but is Oops'ing really
what we want as a bad .config reminder?

hda: completing PM request, suspend
Oops: Kernel access of bad area, Sig: 11 [#1]
NIP: C001CCA8... TASK 'pbbuttonsd'  Last syscall: 54...
Call trace:
  pmz_suspend +0x200/0x21c
  macio_device_suspend +0x4c/0x54
  suspend_device +0xd4/0xdc
  device_suspend +0x64/0xd8
  ...

-dte

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
