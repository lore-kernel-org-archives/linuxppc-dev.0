Date: Mon, 10 Sep 2001 13:15:43 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Dan Malek <dan@mvista.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: 405GP booting
Message-ID: <20010910131543.A6438@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I can boot the kernel and my Ram Disk loads the busybox
shell and I get a prompt but things will lock up after
that. Doing 'ls' and 'df' show nothing. When it does
die I something get this:
-------------
# ls
bi
Please press Enter to activate this console. p
-------------

There is a pause after the "bi". Most of the time
the "Please..." is cut-off around the pr in press.

I have not gone through the entire boot sequence but
one thing in the prints does concern me.

Looking at where the kernel is relocated to and where
the board data is at initially. They seem to overlap.
I don't know if the prints follow the order of the actual
moves though. Does anyone know about this?

Entry point at 0x500000 ...
loaded at:     00500000 0050A244
relocated to:  00400000 0040A244
board data at: 00407174 004071B4
relocated to:  00200100 00200140
zimage at:     00507067 0058D522
initrd at:     0058D522 00679FA8
avail ram:     0067A000 02000000


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
