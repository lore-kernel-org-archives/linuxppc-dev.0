Date: Tue, 10 Jun 2003 01:31:56 -0500 (CDT)
From: "Milton D. Miller II" <miltonm@realtime.net>
Message-Id: <200306100631.h5A6VuFB032511@sullivan.realtime.net>
To: r&d@wawnet.biz
Subject: Re: Initial ramdisk, linuxrc script and handle_initrd function
Cc: linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Why do ROOT_DEV and MKDEV(RAMDISK_MAJOR, 0) need to be different in order
> to execute /linuxrc?
> Am I missing some parameters?
> Any help is appreciated.

False premise, Yes (init=/linuxrc).

See Documentation/initrd.txt in your kernel tree for more info.

milton

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
