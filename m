From: "Ron Bianco" <ronb@junction.net>
To: "Cort Dougan" <cort@fsmlabs.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: linux 2.4.x, PPC and  openPIC interrupt priorities
Date: Wed, 31 Jan 2001 18:27:32 -0800
Message-ID: <000801c08bf6$88362780$4d012ac7@warp-speed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20010131170852.D19501@hq.fsmlabs.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks a lot Cort, that's a big help.

We're wondering if rtlinux-3.0-pre10 patches can also be applied to your latest
bitkeeper 2.4.1-preX  linux.
It is mentioned that the patches are to be applied to linux-2.4.0-test1.

It sure is unfortunate, to my mind, that regular linux handles interrupts that
'enable all/disable all', way.
But I understand the predicament of dealing with tons of different PICs.   Must drive
driver writers nuts. :-)
Might actually make writing linux drivers for some hardware, impossible.

If we think we need mods to RTLinux for our purposes, I'll let you know.

regards, Ron


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
