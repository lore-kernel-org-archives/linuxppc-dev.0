Message-ID: <8D7C5F56B409554D9D46AC22195807F3061C3C@exchwenz01.dmcwave.co.nz>
From: Rod Boyce <rod_boyce@stratexnet.com>
To: "'Muaddi, Cecilia'" <cecilia.muaddi@alloptic.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: bdi2000
Date: Tue, 28 Jan 2003 14:38:45 +1300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I would say from what you have just described you have not set the DER
register correctly.  Instead of just breaking on actual break points you are
breaking on all interrupts.

Our DER register line is set to:

WSPR	149	0x2002000F	; DER : set debug enable register


Regards,
Rod

 -----Original Message-----
From: 	Muaddi, Cecilia [mailto:cecilia.muaddi@alloptic.com]
Sent:	Tuesday, 28 January 2003 2:06 p.m.
To:	'linuxppc-embedded@lists.linuxppc.org'
Subject:	bdi2000


Hello,

I am having some difficulty setting up to work with the abatron bdi2000.  Is
there a mailing list somewhere I can post questions?

Since I am here,  can someone tell me what have I configured incorrectly on
the bdi2000.

I followed the document "Using the Abatro BDI2000 to Debug a Linux Kernel",
and for some reason,
without setting any breakpoint, the bdi2000 always seem to break somehwere
after the print on the console:

Dentry-cache hash table entries: 1024 (order: 1, 8192 bytes)
Inode-cache hash table entries: 512 (order: 0, 4096 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX



When I do an "info" in the bdi telnet window, this is what I got
- TARGET: target has entered debug mode
BDI>info
    Target state      : debug mode
    Debug entry cause : system call
    Current PC        : 0xc0005ebc

Without the BDI2000, the kernel comes up without a problem.

Thanks

Cecilia


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
