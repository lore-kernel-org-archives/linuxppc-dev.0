Date: Sat, 4 Aug 2001 12:18:40 -0500
From: Troy Benjegerdes <hozer@drgw.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: bogus SCSI timeouts and ntpd...
Message-ID: <20010804121840.G17468@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have recently started getting what appear to be 'bogus' SCSI timeouts
after a crash and reboot, when my raid1 is re-syncing. (which amounts to
copying disk1 of the raid to disk2 of the raid.)

This didn't start happening until I started running ntpd at bootup..

I suspect something is broken somewhere such that when ntp adjusts the
time by a small amount, the SCSI layer (and generic timer code??) gets
confused and thinks that SCSI command have timed out.

This is with the current linuxppc_2_4_devel, running on a dual processor
MTX (604ev) with a symbios SCSI chip on-board.

Anyone have any ideas on this, or how to do a testcase to attempt to
verify it?

So does anyone think this is a generic SCSI problem, or something only
with PPC, and the use of timebase for the clock?

--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Shulz

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
