Content-Type: text/plain;
  charset="iso-8859-1"
From: Dustin Byford <dustin@firein.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: custom mpc8240 student project (long)
Date: Mon, 18 Feb 2002 03:33:48 -0700
MIME-Version: 1.0
Message-ID: <auto-000008646423@zipmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

For purely academic purposes I am building an IP router based on an mpc8240
in my "capstone" EE class at NMSU.  I was wondering if someone who may have
done something similar could tell me if I'm working in the right direction.
I've done some research with the list archives and I think I have decided on
a basic hardware layout.  I'm just wondering if my ideas are sane and I have
a couple of questions.

I will be wire-wrapping the entire design (sockets have been acquired) and
and plan to use:

MPC8240 (At ~30MHz bus)
National 16550 UART connected to RCS1, etc...
2 16-bit flash ROMs (8MByte total) (Am29LV320D x2) connected toRCS0, etc...
128MB SDRAM in 1 DIMM
PCI (wire wrap board attached to a backplane) with 2 FA310TX netgear cards
There is also a reset circuit, a power supply, and I'm guessing I need a
buffer between the UART and the CPU and a MAX232 for serial line driving.

I also planned to start out by programming the ROMs through the BDM/JTAG port
on the CPU.  I'll start with the GDB target for MPCs and attempt to load a
program into RAM to program the 2 flashes, with--ppcboot.  Hopefully this
will allow me to run the 2.4_devel version of the ppc kernel, busybox/uclibc
as a distro and iptables as the "router".

I'm expecting many frustrations (I mean learning experiences) along the way
and I suppose I'll begin with sandpoint code for ppcboot and the kernel.

So, what do you think.  Will it work?  Also, is there maybe a different
kernel I should start out with.  Anybody see any major pitfalls?

Also, in the chance that this works I would love to PCB it and fire it up at
200 MHz/100MHz Memory/66MHz PCI and then hang it on my wall because I have to
give the 8240 back to my professor.  I can design the PCB but what is the
cheapest way to get a 4-6 layer board done.

Thanks for any and all advice!

			--Dustin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
