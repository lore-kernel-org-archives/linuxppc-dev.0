Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "Dustin Byford" <dustin@firein.net>
Subject: Re: custom mpc8240 student project (long)
To: Langus Matevz RDHW_EXT <langus@iskratel.si>,
	linuxppc-embedded@lists.linuxppc.org
Date: Mon, 18 Feb 2002 16:17:24 -0500
Message-ID: <web-8690106@zipmail.com>
In-Reply-To: <7E8519F1A7C0D211B0D200A0C93AA60F08447D20@ntmail.iskratel.si>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for your response.  I was hoping to use something I
 build myself to do the BDM programming.  Something similar
 to what people are doing for the LART project with JFlash.
  I understand a NDA is required for all the details about
 the JTAG/COP port on the MPC8240 but all I really need
 here is basic flash programming so I can bootstrap
 something that will load a real bootloader through the
 uart.  Is enough information about the BDM available to do
 this?  I'm not afraid of hacking something together if the
 information is there.

Thanks again.


      --Dustin


On Mon, 18 Feb 2002 21:17:26 +0100
 Langus Matevz    RDHW_EXT <langus@iskratel.si> wrote:
> Hi!
>
> I don't see any reasons to add buffers betwen UART and
>  CPU. Max232 does all
> driving usually.
>
> Programming Flash thru BDM is a good idea, just be
>  careful which BDM
> debugger you will buy. I have a lot of problems with
>  Windriver's
> visionProbe-II and visionICE-II. They do not work with
>  never versions of
> MPC8260 - I need to renew (and pay) licence in order to
>  get it working. And
> Windriver is responding very slowly...
> Choose another one.
>
> >but what is the cheapest way to get a 4-6 layer board
>  done.
>
> Try www.iskratel-electronics.si
>
> Matevz
>
> -----Original Message-----
> From: Dustin Byford [mailto:dustin@firein.net]
> Sent: Monday, February 18, 2002 11:34 AM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: custom mpc8240 student project (long)
>
>
>
> Hi,
>
> For purely academic purposes I am building an IP router
>  based on an mpc8240
> in my "capstone" EE class at NMSU.  I was wondering if
>  someone who may have
> done something similar could tell me if I'm working in
>  the right direction.
> I've done some research with the list archives and I
>  think I have decided on
> a basic hardware layout.  I'm just wondering if my ideas
>  are sane and I have
> a couple of questions.
>
> I will be wire-wrapping the entire design (sockets have
>  been acquired) and
> and plan to use:
>
> MPC8240 (At ~30MHz bus)
> National 16550 UART connected to RCS1, etc...
> 2 16-bit flash ROMs (8MByte total) (Am29LV320D x2)
>  connected toRCS0, etc...
> 128MB SDRAM in 1 DIMM PCI (wire wrap board attached to a
>  backplane) with 2
> FA310TX netgear cards There is also a reset circuit, a
>  power supply, and I'm
> guessing I need a buffer between the UART and the CPU and
>  a MAX232 for
> serial line driving.
>
> I also planned to start out by programming the ROMs
>  through the BDM/JTAG
> port on the CPU.  I'll start with the GDB target for MPCs
>  and attempt to
> load a program into RAM to program the 2 flashes,
>  with--ppcboot.  Hopefully
> this will allow me to run the 2.4_devel version of the
>  ppc kernel,
> busybox/uclibc as a distro and iptables as the "router".
>
> I'm expecting many frustrations (I mean learning
>  experiences) along the way
> and I suppose I'll begin with sandpoint code for ppcboot
>  and the kernel.
>
> So, what do you think.  Will it work?  Also, is there
>  maybe a different
> kernel I should start out with.  Anybody see any major
>  pitfalls?
>
> Also, in the chance that this works I would love to PCB
>  it and fire it up at
> 200 MHz/100MHz Memory/66MHz PCI and then hang it on my
>  wall because I have
> to give the 8240 back to my professor.  I can design the
>  PCB but what is the
> cheapest way to get a 4-6 layer board done.
>
> Thanks for any and all advice!
>
> 			--Dustin
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
