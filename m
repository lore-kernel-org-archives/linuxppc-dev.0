Message-ID: <002e01bfe854$c4019c40$1a6a1504@strayer.edu>
From: "Robert Thompson" <rothomp3@vt.edu>
To: <linuxppc-dev@lists.linuxppc.org>
Cc: <bh40@calva.net>
Subject: 2.2.17pre9-ben1 and airport
Date: Fri, 7 Jul 2000 16:48:53 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi, I have an iBook SE with an airport card, so naturally I was quite
excited at the prospect of being able to use 32bit color (finally!) under
Linux, and the AirPort card as well. So, I downloaded the source from
ppclinux.apple.com/~benh, and built a new kernel. First of all, the mach64
stuff seems to work fine with Xpmac, but the XF68_FBDev that's installed on
my Yellow Dog 1.2 machine just puts a weird line on the screen. Oh well, no
biggie, since Xpmac is working. I haven't tried XF4 yet, either. Now, on to
the problems...
1.) The trackpad won't work at all anymore, but external USB mice work fine.
I did make the prerequisite changes in /dev.
2.) When I try to insmod airport.o network_name=home it claims that printk
and isa_io_base are unresolved symbols.

Any ideas?

Thanks,
Robbie Thompson


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
