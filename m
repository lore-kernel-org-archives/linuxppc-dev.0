Return-Path: <babu.pci81@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.186])
	by ozlabs.org (Postfix) with ESMTP id 85A05DDDFC
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 07:32:07 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so712228rvf
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 14:32:06 -0700 (PDT)
Message-ID: <a38e30640709141432u952c029h9fd38263fe9b6412@mail.gmail.com>
Date: Sat, 15 Sep 2007 03:02:05 +0530
From: "lakshminarayana babu" <babu.pci81@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Linuxppc-dev Digest, Vol 37, Issue 87
In-Reply-To: <mailman.2017.1189665433.2970.linuxppc-dev@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2499_19661013.1189805525257"
References: <mailman.2017.1189665433.2970.linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_2499_19661013.1189805525257
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Is there anyone having sample pci circuit for outputting data and display it
in the form of leds.

thank you and regards
babu

On 9/13/07, linuxppc-dev-request@ozlabs.org <linuxppc-dev-request@ozlabs.org>
wrote:
>
> Send Linuxppc-dev mailing list submissions to
>         linuxppc-dev@ozlabs.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>         https://ozlabs.org/mailman/listinfo/linuxppc-dev
> or, via email, send a message with subject or body 'help' to
>         linuxppc-dev-request@ozlabs.org
>
> You can reach the person managing the list at
>         linuxppc-dev-owner@ozlabs.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Linuxppc-dev digest..."
>
>
> Today's Topics:
>
>    1. Re: Linuxppc-dev Digest, Vol 37, Issue 84 (lakshminarayana babu)
>    2. Re: 2.6.23-rc3 boot hang on MPC8641D (sivaji)
>    3. Re: 2.6.23-rc3 boot hang on MPC8641D (David Gibson)
>    4. RE: 2.6.23-rc3 boot hang on MPC8641D (sivaji)
>    5. Re: Linuxppc-dev Digest, Vol 37, Issue 84 (Kumar Gala)
>    6. Re: 2.6.23-rc3 boot hang on MPC8641D (Michael Ellerman)
>    7. Make mpc82xx use generic_calibrate_decr() (David Gibson)
>    8. Re: [PATCH 10/10] mpc82xx: Add pq2fads board support. (Kumar Gala)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Thu, 13 Sep 2007 10:53:57 +0530
> From: "lakshminarayana babu" <babu.pci81@gmail.com>
> Subject: Re: Linuxppc-dev Digest, Vol 37, Issue 84
> To: "Olof Johansson" <olof@lixom.net>
> Cc: linuxppc-dev@ozlabs.org
> Message-ID:
>         <a38e30640709122223m60913ad5xf3c95e636e3b3350@mail.gmail.com>
> Content-Type: text/plain; charset="iso-8859-1"
>
> sir,
>    can you plese suggest any book for pci driver writing...At present i am
> studying linux device drivers by alexandrorubini
>
> On 9/13/07, Olof Johansson <olof@lixom.net> wrote:
> >
> > On Thu, Sep 13, 2007 at 10:01:36AM +0530, lakshminarayana babu wrote:
> > > i am new to the linux.....can you tell me how to access the pci
> > > configuration space using ioremap function...but  it is implicit
> > function
> > > declaration...
> >
> > That is architecture and platform dependent. Some platforms don't even
> > have a memory-mappable interface to configuration space.
> >
> > Instead, please use the abstracted config access functions that the
> > kernel provides. (pci_read_config_word and friends).
> >
> >
> > -Olof
> >
> -------------- next part --------------
> An HTML attachment was scrubbed...
> URL:
> http://ozlabs.org/pipermail/linuxppc-dev/attachments/20070913/2aa5ccff/attachment-0001.htm
>
> ------------------------------
>
> Message: 2
> Date: Wed, 12 Sep 2007 22:24:22 -0700 (PDT)
> From: sivaji <rameshmrm@gmail.com>
> Subject: Re: 2.6.23-rc3 boot hang on MPC8641D
> To: linuxppc-dev@ozlabs.org
> Message-ID: <12648913.post@talk.nabble.com>
> Content-Type: text/plain; charset=us-ascii
>
>
>
> Hi,
>         I am not willing to upgrade the uboot. Becuase it takes some time
> to
> port the new uboot for my custom boad.
> whether the current problem is related to uboot ? One more point,
> previously
> i tried 2.6.21 with the same uboot(1.1.6) we got linux prompt but we face
> some issue in the pci express in that version. so we plan to upgrade the
> kernel version.
> by
> Sivaji
>
> Kumar Gala-3 wrote:
> >
> >
> > On Sep 12, 2007, at 11:52 PM, sivaji wrote:
> >
> >>
> >>
> >> Hi,
> >>           I tired to move the dtb to 0x2000000, but the result was
> >> same.
> >> uboot version is 1.1.6
> >
> > seems like a pretty old u-boot.  Willing to try a 1.3.0-rc1?
> >
> > - k
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> >
> >
>
> --
> View this message in context:
> http://www.nabble.com/2.6.23-rc3-boot-hang-on-MPC8641D-tf4433508.html#a12648913
> Sent from the linuxppc-dev mailing list archive at Nabble.com.
>
>
>
> ------------------------------
>
> Message: 3
> Date: Thu, 13 Sep 2007 15:29:32 +1000
> From: David Gibson <david@gibson.dropbear.id.au>
> Subject: Re: 2.6.23-rc3 boot hang on MPC8641D
> To: sivaji <rameshmrm@gmail.com>
> Cc: linuxppc-dev@ozlabs.org
> Message-ID: <20070913052932.GF14905@localhost.localdomain>
> Content-Type: text/plain; charset=us-ascii
>
> On Wed, Sep 12, 2007 at 10:24:22PM -0700, sivaji wrote:
> >
> >
> > Hi,
> >         I am not willing to upgrade the uboot. Becuase it takes some
> time to
> > port the new uboot for my custom boad.
> > whether the current problem is related to uboot ? One more point,
> previously
> > i tried 2.6.21 with the same uboot(1.1.6) we got linux prompt but we
> face
> > some issue in the pci express in that version. so we plan to upgrade the
> > kernel version.
>
> I thought u-boot < 1.3 didn't understand the flat tree at all.  In
> which case you'll need a cuboot zImage.
>
> --
> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_
> _other_
>                                 | _way_ _around_!
> http://www.ozlabs.org/~dgibson
>
>
> ------------------------------
>
> Message: 4
> Date: Wed, 12 Sep 2007 22:32:24 -0700 (PDT)
> From: sivaji <rameshmrm@gmail.com>
> Subject: RE: 2.6.23-rc3 boot hang on MPC8641D
> To: linuxppc-dev@ozlabs.org
> Message-ID: <12648963.post@talk.nabble.com>
> Content-Type: text/plain; charset=us-ascii
>
>
> Hi,
>           Sorry i specify the wrong version, we r using 1.2.0. This uboot
> was taken from the BSP which was released by Freescale. Previously we
> tested
> linux 2.6.21 kernel, we got linux prompt. For this we are using the same
> uboot(1.2.0).
> In that version we face some issues in the pci express, at that time kumar
> suggest to upgrade the kernel verison 2.6.23-rc3.
> Zhang did u suspect the problem is related to uboot?.
> by
> sivaji
>
>
> Zhang Wei-r63237 wrote:
> >
> > Yes, It's too old. Maybe not fully supports FDT. You can try the version
> > of Kumar said or in the BSP of Freescale released.
> >
> > - zw
> >
> >> -----Original Message-----
> >> From: linuxppc-dev-bounces+wei.zhang=freescale.com@ozlabs.org
> >> [mailto:linuxppc-dev-bounces+wei.zhang=freescale.com@ozlabs.or
> >> g] On Behalf Of Kumar Gala
> >> Sent: Thursday, September 13, 2007 1:11 PM
> >> To: sivaji
> >> Cc: linuxppc-dev@ozlabs.org
> >> Subject: Re: 2.6.23-rc3 boot hang on MPC8641D
> >>
> >>
> >> On Sep 12, 2007, at 11:52 PM, sivaji wrote:
> >>
> >> >
> >> >
> >> > Hi,
> >> >           I tired to move the dtb to 0x2000000, but the result was
> >> > same.
> >> > uboot version is 1.1.6
> >>
> >> seems like a pretty old u-boot.  Willing to try a 1.3.0-rc1?
> >>
> >> - k
> >> _______________________________________________
> >> Linuxppc-dev mailing list
> >> Linuxppc-dev@ozlabs.org
> >> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> >>
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> >
> >
>
> --
> View this message in context:
> http://www.nabble.com/2.6.23-rc3-boot-hang-on-MPC8641D-tf4433508.html#a12648963
> Sent from the linuxppc-dev mailing list archive at Nabble.com.
>
>
>
> ------------------------------
>
> Message: 5
> Date: Thu, 13 Sep 2007 00:58:18 -0500
> From: Kumar Gala <galak@kernel.crashing.org>
> Subject: Re: Linuxppc-dev Digest, Vol 37, Issue 84
> To: "lakshminarayana babu" <babu.pci81@gmail.com>
> Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
> Message-ID: <93B3AC37-A4E7-46BD-8484-F074911A9A44@kernel.crashing.org>
> Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
>
>
> On Sep 13, 2007, at 12:23 AM, lakshminarayana babu wrote:
>
> > sir,
> >    can you plese suggest any book for pci driver writing...At
> > present i am studying linux device drivers by alexandrorubini
>
> That's about as good as it gets.  It covers writing a pci driver in
> there.
>
> - k
>
>
> ------------------------------
>
> Message: 6
> Date: Thu, 13 Sep 2007 15:59:32 +1000
> From: Michael Ellerman <michael@ellerman.id.au>
> Subject: Re: 2.6.23-rc3 boot hang on MPC8641D
> To: Kumar Gala <galak@kernel.crashing.org>
> Cc: linuxppc-dev@ozlabs.org, sivaji <rameshmrm@gmail.com>
> Message-ID: <1189663172.20396.1.camel@concordia.ozlabs.ibm.com>
> Content-Type: text/plain; charset="us-ascii"
>
> On Thu, 2007-09-13 at 00:13 -0500, Kumar Gala wrote:
> > On Sep 12, 2007, at 11:47 PM, sivaji wrote:
> >
> > >
> > >
> > > Hi,
> > >           I have JTAG Debugger connected to the board. I was given the
> > > following commands in the root path of the kernel source
> >
> > If you can dump memory w/o connecting GDB, I suggest the following.
> >
> > Look in your kernel build for System.map and grep for log_buf you
> > should get something like:
> >
> > c040b04c d log_buf
> > c043b1a4 b __log_buf
> >
> > then dump the memory @ these addresses.  I can't remember which one
> > is the correct one.  You'll want to subtract c000_0000 from the
> > address to get a physical address that you can dump.  This should
> > help provide some possible insight into what's going on.
>
> __log_buf is the actual buffer, log_buf points to the current insertion
> point IIRC. It should be pretty obvious that you're looking at a dmesg
> buffer though, unless there's nothing in there for some reason.
>
> cheers
>
> --
> Michael Ellerman
> OzLabs, IBM Australia Development Lab
>
> wwweb: http://michael.ellerman.id.au
> phone: +61 2 6212 1183 (tie line 70 21183)
>
> We do not inherit the earth from our ancestors,
> we borrow it from our children. - S.M.A.R.T Person
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: not available
> Type: application/pgp-signature
> Size: 189 bytes
> Desc: This is a digitally signed message part
> Url :
> http://ozlabs.org/pipermail/linuxppc-dev/attachments/20070913/30f05247/attachment-0001.pgp
>
> ------------------------------
>
> Message: 7
> Date: Thu, 13 Sep 2007 16:22:01 +1000
> From: David Gibson <david@gibson.dropbear.id.au>
> Subject: Make mpc82xx use generic_calibrate_decr()
> To: Kumar Gala <galak@kernel.crashing.org>,     Tony Breeds
>         <tony@bakeyournoodle.com>, linuxppc-dev@ozlabs.org
> Message-ID: <20070913062201.GA24281@localhost.localdomain>
> Content-Type: text/plain; charset=us-ascii
>
> The only difference between m82xx_calibrate_decr() and
> generic_calibrate_decr() is that the former computes the timebase
> frequency from the cpu node's bus-frequency property, instead of
> directly from the timebase-frequency property.
>
> But there's no reason the timebase-frequency shouldn't be correct on
> 82xx like everything else.  Certainly the 82xx bootwrapper in
> arch/powerpc/boot/cuboot-pq2.c should get it right.
>
> Therefore, this patch removes mpc82xx_calibrate_decr(), using
> generic_calibrate_decr() instead.
>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>
> I've compiled this, but no booted it, since I don't have any 82xx
> hardware.  I'm hoping for an ack from someone who can test boot it.
>
> Index: working-2.6/arch/powerpc/platforms/82xx/mpc82xx_ads.c
> ===================================================================
> --- working-2.6.orig/arch/powerpc/platforms/82xx/mpc82xx_ads.c  2007-09-13
> 16:14:18.000000000 +1000
> +++ working-2.6/arch/powerpc/platforms/82xx/mpc82xx_ads.c       2007-09-13
> 16:14:38.000000000 +1000
> @@ -635,6 +635,6 @@ define_machine(mpc82xx_ads)
>         .init_IRQ =    mpc82xx_ads_pic_init,
>         .show_cpuinfo =    mpc82xx_ads_show_cpuinfo,
>         .get_irq =    cpm2_get_irq,
> -       .calibrate_decr =    m82xx_calibrate_decr,
> +       .calibrate_decr = generic_calibrate_decr,
>         .restart = m82xx_restart,.halt = m82xx_halt,
> };
> Index: working-2.6/arch/powerpc/platforms/82xx/mpc82xx.c
> ===================================================================
> --- working-2.6.orig/arch/powerpc/platforms/82xx/mpc82xx.c      2007-09-13
> 16:13:48.000000000 +1000
> +++ working-2.6/arch/powerpc/platforms/82xx/mpc82xx.c   2007-09-13 16:15:
> 13.000000000 +1000
> @@ -51,42 +51,6 @@
>
> #include "pq2ads.h"
>
> -static int __init get_freq(char *name, unsigned long *val)
> -{
> -       struct device_node *cpu;
> -       const unsigned int *fp;
> -       int found = 0;
> -
> -       /* The cpu node should have timebase and clock frequency
> properties */
> -       cpu = of_find_node_by_type(NULL, "cpu");
> -
> -       if (cpu) {
> -               fp = of_get_property(cpu, name, NULL);
> -               if (fp) {
> -                       found = 1;
> -                       *val = *fp;
> -               }
> -
> -               of_node_put(cpu);
> -       }
> -
> -       return found;
> -}
> -
> -void __init m82xx_calibrate_decr(void)
> -{
> -       ppc_tb_freq = 125000000;
> -       if (!get_freq("bus-frequency", &ppc_tb_freq)) {
> -               printk(KERN_ERR "WARNING: Estimating decrementer frequency
> "
> -                               "(not found)\n");
> -       }
> -       ppc_tb_freq /= 4;
> -       ppc_proc_freq = 1000000000;
> -       if (!get_freq("clock-frequency", &ppc_proc_freq))
> -               printk(KERN_ERR "WARNING: Estimating processor frequency"
> -                               "(not found)\n");
> -}
> -
> void mpc82xx_ads_show_cpuinfo(struct seq_file *m)
> {
>         uint pvid, svid, phid1;
>
> --
> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_
> _other_
>                                 | _way_ _around_!
> http://www.ozlabs.org/~dgibson
>
>
> ------------------------------
>
> Message: 8
> Date: Thu, 13 Sep 2007 01:39:58 -0500
> From: Kumar Gala <galak@kernel.crashing.org>
> Subject: Re: [PATCH 10/10] mpc82xx: Add pq2fads board support.
> To: Scott Wood <scottwood@freescale.com>
> Cc: linuxppc-dev@ozlabs.org
> Message-ID: <9BC5B02A-4E9D-42DD-90C3-F8C3382F2A96@kernel.crashing.org>
> Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
>
> > diff --git a/arch/powerpc/boot/dts/pq2fads.dts b/arch/powerpc/boot/
> > dts/pq2fads.dts
> > new file mode 100644
> > index 0000000..ad736f8
> > --- /dev/null
> > +++ b/arch/powerpc/boot/dts/pq2fads.dts
> > @@ -0,0 +1,236 @@
> > +/*
> > + * Device Tree for the PQ2FADS-ZU board with an MPC8280 chip.
> > + *
> > + * Copyright 2007 Freescale Semiconductor Inc.
> > + *
> > + * This program is free software; you can redistribute  it and/or
> > modify it
> > + * under  the terms of  the GNU General  Public License as
> > published by the
> > + * Free Software Foundation;  either version 2 of the  License, or
> > (at your
> > + * option) any later version.
> > + */
> > +
> > +/ {
> > +     model = "pq2fads";
> > +     compatible = "fsl,pq2fads";
> > +     #address-cells = <1>;
> > +     #size-cells = <1>;
> > +
> > +     cpus {
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +
> > +             cpu@0 {
> > +                     device_type = "cpu";
> > +                     reg = <0>;
> > +                     d-cache-line-size = <d#32>;
> > +                     i-cache-line-size = <d#32>;
> > +                     d-cache-size = <d#16384>;
> > +                     i-cache-size = <d#16384>;
> > +                     timebase-frequency = <0>;
> > +                     clock-frequency = <0>;
> > +             };
> > +     };
> > +
> > +     CS: chipselect {
>
> We need to document this in booting-without-of.
>
> > +             compatible = "fsl,pq2fads-chipselect",
> > +                          "fsl,mpc8280-chipselect",
> > +                          "fsl,pq2-chipselect";
> > +             #address-cells = <2>;
> > +             #size-cells = <1>;
> > +             fsl,ctrl = <&CSCTRL>;
> > +
> > +             ranges = <0 0 fe000000 00800000
> > +                       1 0 f4500000 00008000
> > +                       8 0 f8200000 00008000>;
> > +
> > +             flash@0,0 {
> > +                     device_type = "rom";
> > +                     compatible = "direct-mapped";
> > +                     reg = <0 0 800000>;
> > +                     probe-type = "JEDEC";
> > +                     bank-width = <4>;
> > +             };
> > +
> > +             bcsr@1,0 {
> > +                     reg = <1 0 20>;
> > +                     compatible = "fsl,pq2fads-bcsr";
> > +             };
> > +
> > +             PCI_PIC: pic@8,0 {
> > +                     #interrupt-cells = <1>;
> > +                     interrupt-controller;
> > +                     reg = <8 0 8>;
> > +                     compatible = "fsl,pq2ads-pci-pic";
> > +                     interrupt-parent = <&PIC>;
> > +                     interrupts = <18 8>;
> > +             };
> > +     };
> > +
> > +     memory {
> > +             device_type = "memory";
> > +             reg = <0 0>;
> > +     };
> > +
> > +     soc@f0000000 {
> > +             #address-cells = <1>;
> > +             #size-cells = <1>;
> > +             device_type = "soc";
> > +             compatible = "fsl,mpc8280", "fsl,pq2-soc";
> > +             ranges = <00000000 f0000000 00053000
> > +                       80000000 80000000 40000000
> > +                       f6000000 f6000000 02000000>;
> > +
> > +             CSCTRL: chipselect {
> > +                     compatible = "fsl,mpc8280-chipselect-ctrl",
> > +                                  "fsl,pq2-chipselect-ctrl";
> > +                     reg = <10100 60>;
> > +                     fsl,bus = <&CS>;
> > +             };
> > +
> > +             cpm@119c0 {
> > +                     #address-cells = <1>;
> > +                     #size-cells = <1>;
> > +                     #interrupt-cells = <2>;
> > +                     compatible = "fsl,mpc8280-cpm", "fsl,cpm2";
> > +                     reg = <119c0 30 0 2000>;
> > +                     ranges;
> > +
> > +                     brg@119f0 {
> > +                             compatible = "fsl,mpc8280-brg",
> > +                                          "fsl,cpm2-brg",
> > +                                          "fsl,cpm-brg";
> > +                             reg = <119f0 10 115f0 10>;
> > +                     };
> > +
> > +                     serial@11a00 {
> > +                             device_type = "serial";
> > +                             compatible = "fsl,mpc8280-scc-uart",
> > +                                          "fsl,cpm2-scc-uart";
> > +                             reg = <11a00 20 8000 100>;
> > +                             interrupts = <28 8>;
> > +                             interrupt-parent = <&PIC>;
> > +                             fsl,cpm-brg = <1>;
> > +                             fsl,cpm-command = <00800000>;
> > +                     };
> > +
> > +                     serial@11a20 {
> > +                             device_type = "serial";
> > +                             compatible = "fsl,mpc8280-scc-uart",
> > +                                          "fsl,cpm2-scc-uart";
> > +                             reg = <11a20 20 8100 100>;
> > +                             interrupts = <29 8>;
> > +                             interrupt-parent = <&PIC>;
> > +                             fsl,cpm-brg = <2>;
> > +                             fsl,cpm-command = <04a00000>;
> > +                     };
> > +
> > +                     ethernet@11320 {
> > +                             device_type = "network";
> > +                             compatible = "fsl,mpc8280-fcc-enet",
> > +                                          "fsl,cpm2-fcc-enet";
> > +                             reg = <11320 20 8500 100 113b0 1>;
> > +                             interrupts = <21 8>;
> > +                             interrupt-parent = <&PIC>;
> > +                             phy-handle = <&PHY0>;
> > +                             linux,network-index = <0>;
> > +                             fsl,cpm-command = <16200300>;
> > +                     };
> > +
> > +                     ethernet@11340 {
> > +                             device_type = "network";
> > +                             compatible = "fsl,mpc8280-fcc-enet",
> > +                                          "fsl,cpm2-fcc-enet";
> > +                             reg = <11340 20 8600 100 113d0 1>;
> > +                             interrupts = <22 8>;
> > +                             interrupt-parent = <&PIC>;
> > +                             phy-handle = <&PHY1>;
> > +                             linux,network-index = <1>;
> > +                             fsl,cpm-command = <1a400300>;
> > +                             local-mac-address = [00 e0 0c 00 79 01];
> > +                     };
> > +
> > +                     mdio@10d40 {
> > +                             device_type = "mdio";
> > +                             compatible = "fsl,pq2fads-mdio-bitbang",
> > +                                          "fsl,mpc8280-mdio-bitbang",
> > +                                          "fsl,cpm2-mdio-bitbang";
> > +                             #address-cells = <1>;
> > +                             #size-cells = <0>;
> > +                             reg = <10d40 14>;
> > +                             fsl,mdio-pin = <9>;
> > +                             fsl,mdc-pin = <a>;
> > +
> > +                             PHY0: ethernet-phy@0 {
> > +                                     interrupt-parent = <&PIC>;
> > +                                     interrupts = <19 2>;
> > +                                     reg = <0>;
> > +                                     device_type = "ethernet-phy";
> > +                             };
> > +
> > +                             PHY1: ethernet-phy@1 {
> > +                                     interrupt-parent = <&PIC>;
> > +                                     interrupts = <19 2>;
> > +                                     reg = <3>;
> > +                                     device_type = "ethernet-phy";
> > +                             };
> > +                     };
> > +
> > +                     usb@11b60 {
> > +                             #address-cells = <1>;
> > +                             #size-cells = <0>;
> > +                             compatible = "fsl,mpc8280-usb",
> > +                                          "fsl,cpm2-usb";
> > +                             reg = <11b60 18 8b00 100>;
> > +                             interrupt-parent = <&PIC>;
> > +                             interrupts = <b 8>;
> > +                             fsl,cpm-command = <2e600000>;
> > +                     };
> > +             };
> > +
> > +             PIC: interrupt-controller@10c00 {
> > +                     #interrupt-cells = <2>;
> > +                     interrupt-controller;
> > +                     reg = <10c00 80>;
> > +                     compatible = "fsl,mpc8280-pic", "fsl,pq2-pic";
>
> this should also have a "fsl,cpm2-pic" or something of that form.
> (exact same pic exists on 8560, 85xx+CPM)
>
> > +             };
> > +
> > +             pci@10800 {
> > +                     device_type = "pci";
> > +                     reg = <10800 10c 101ac 8 101c4 8>;
> > +                     compatible = "fsl,mpc8280-pci", "fsl,pq2-pci";
> > +                     #interrupt-cells = <1>;
> > +                     #size-cells = <2>;
> > +                     #address-cells = <3>;
> > +                     clock-frequency = <d#66000000>;
> > +                     interrupt-map-mask = <f800 0 0 7>;
> > +                     interrupt-map = <
> > +                                     /* IDSEL 0x16 */
> > +                                      b000 0 0 1 &PCI_PIC 0
> > +                                      b000 0 0 2 &PCI_PIC 1
> > +                                      b000 0 0 3 &PCI_PIC 2
> > +                                      b000 0 0 4 &PCI_PIC 3
> > +
> > +                                     /* IDSEL 0x17 */
> > +                                      b800 0 0 1 &PCI_PIC 4
> > +                                      b800 0 0 2 &PCI_PIC 5
> > +                                      b800 0 0 3 &PCI_PIC 6
> > +                                      b800 0 0 4 &PCI_PIC 7
> > +
> > +                                     /* IDSEL 0x18 */
> > +                                      c000 0 0 1 &PCI_PIC 8
> > +                                      c000 0 0 2 &PCI_PIC 9
> > +                                      c000 0 0 3 &PCI_PIC a
> > +                                      c000 0 0 4 &PCI_PIC b>;
> > +
> > +                     interrupt-parent = <&PIC>;
> > +                     interrupts = <12 8>;
> > +                     ranges = <42000000 0 80000000 80000000 0 20000000
> > +                               02000000 0 a0000000 a0000000 0 20000000
> > +                               01000000 0 00000000 f6000000 0
> 02000000>;
> > +             };
> > +     };
> > +
> > +     chosen {
> > +             linux,stdout-path = "/soc/cpm/serial@11a00";
> > +     };
> > +};
>
> - k
>
>
>
>
> ------------------------------
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
> End of Linuxppc-dev Digest, Vol 37, Issue 87
> ********************************************
>

------=_Part_2499_19661013.1189805525257
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Is there anyone having sample pci circuit for outputting data and display i=
t in the form of leds.<br><br>thank you and regards<br>babu<br><br><div><sp=
an class=3D"gmail_quote">On 9/13/07, <b class=3D"gmail_sendername"><a href=
=3D"mailto:linuxppc-dev-request@ozlabs.org">
linuxppc-dev-request@ozlabs.org</a></b> &lt;<a href=3D"mailto:linuxppc-dev-=
request@ozlabs.org">linuxppc-dev-request@ozlabs.org</a>&gt; wrote:</span><b=
lockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 20=
4, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Send Linuxppc-dev mailing list submissions to<br>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;<a href=3D"mailto:linuxppc-dev@ozlabs.org">linuxppc-d=
ev@ozlabs.org</a><br><br>To subscribe or unsubscribe via the World Wide Web=
, visit<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=3D"https=
://ozlabs.org/mailman/listinfo/linuxppc-dev">
https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br>or, via email, send=
 a message with subject or body &#39;help&#39; to<br>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;<a href=3D"mailto:linuxppc-dev-request@ozlabs.org=
">linuxppc-dev-request@ozlabs.org</a><br>
<br>You can reach the person managing the list at<br>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;<a href=3D"mailto:linuxppc-dev-owner@ozlabs.org">=
linuxppc-dev-owner@ozlabs.org</a><br><br>When replying, please edit your Su=
bject line so it is more specific<br>than &quot;Re: Contents of Linuxppc-de=
v digest...&quot;
<br><br><br>Today&#39;s Topics:<br><br>&nbsp;&nbsp; 1. Re: Linuxppc-dev Dig=
est, Vol 37, Issue 84 (lakshminarayana babu)<br>&nbsp;&nbsp; 2. Re: 2.6.23-=
rc3 boot hang on MPC8641D (sivaji)<br>&nbsp;&nbsp; 3. Re: 2.6.23-rc3 boot h=
ang on MPC8641D (David Gibson)
<br>&nbsp;&nbsp; 4. RE: 2.6.23-rc3 boot hang on MPC8641D (sivaji)<br>&nbsp;=
&nbsp; 5. Re: Linuxppc-dev Digest, Vol 37, Issue 84 (Kumar Gala)<br>&nbsp;&=
nbsp; 6. Re: 2.6.23-rc3 boot hang on MPC8641D (Michael Ellerman)<br>&nbsp;&=
nbsp; 7. Make mpc82xx use generic_calibrate_decr() (David Gibson)
<br>&nbsp;&nbsp; 8. Re: [PATCH 10/10] mpc82xx: Add pq2fads board support. (=
Kumar Gala)<br><br><br>----------------------------------------------------=
------------------<br><br>Message: 1<br>Date: Thu, 13 Sep 2007 10:53:57 +05=
30<br>
From: &quot;lakshminarayana babu&quot; &lt;<a href=3D"mailto:babu.pci81@gma=
il.com">babu.pci81@gmail.com</a>&gt;<br>Subject: Re: Linuxppc-dev Digest, V=
ol 37, Issue 84<br>To: &quot;Olof Johansson&quot; &lt;<a href=3D"mailto:olo=
f@lixom.net">
olof@lixom.net</a>&gt;<br>Cc: <a href=3D"mailto:linuxppc-dev@ozlabs.org">li=
nuxppc-dev@ozlabs.org</a><br>Message-ID:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&lt;<a href=3D"mailto:a38e30640709122223m60913ad5xf3c95e63=
6e3b3350@mail.gmail.com">a38e30640709122223m60913ad5xf3c95e636e3b3350@mail.=
gmail.com
</a>&gt;<br>Content-Type: text/plain; charset=3D&quot;iso-8859-1&quot;<br><=
br>sir,<br>&nbsp;&nbsp; can you plese suggest any book for pci driver writi=
ng...At present i am<br>studying linux device drivers by alexandrorubini<br=
><br>On 9/13/07, Olof Johansson &lt;
<a href=3D"mailto:olof@lixom.net">olof@lixom.net</a>&gt; wrote:<br>&gt;<br>=
&gt; On Thu, Sep 13, 2007 at 10:01:36AM +0530, lakshminarayana babu wrote:<=
br>&gt; &gt; i am new to the linux.....can you tell me how to access the pc=
i
<br>&gt; &gt; configuration space using ioremap function...but&nbsp;&nbsp;i=
t is implicit<br>&gt; function<br>&gt; &gt; declaration...<br>&gt;<br>&gt; =
That is architecture and platform dependent. Some platforms don&#39;t even<=
br>&gt; have a memory-mappable interface to configuration space.
<br>&gt;<br>&gt; Instead, please use the abstracted config access functions=
 that the<br>&gt; kernel provides. (pci_read_config_word and friends).<br>&=
gt;<br>&gt;<br>&gt; -Olof<br>&gt;<br>-------------- next part -------------=
-
<br>An HTML attachment was scrubbed...<br>URL: <a href=3D"http://ozlabs.org=
/pipermail/linuxppc-dev/attachments/20070913/2aa5ccff/attachment-0001.htm">=
http://ozlabs.org/pipermail/linuxppc-dev/attachments/20070913/2aa5ccff/atta=
chment-0001.htm
</a><br><br>------------------------------<br><br>Message: 2<br>Date: Wed, =
12 Sep 2007 22:24:22 -0700 (PDT)<br>From: sivaji &lt;<a href=3D"mailto:rame=
shmrm@gmail.com">rameshmrm@gmail.com</a>&gt;<br>Subject: Re: 2.6.23-rc3 boo=
t hang on MPC8641D
<br>To: <a href=3D"mailto:linuxppc-dev@ozlabs.org">linuxppc-dev@ozlabs.org<=
/a><br>Message-ID: &lt;<a href=3D"mailto:12648913.post@talk.nabble.com">126=
48913.post@talk.nabble.com</a>&gt;<br>Content-Type: text/plain; charset=3Du=
s-ascii
<br><br><br><br>Hi,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I am=
 not willing to upgrade the uboot. Becuase it takes some time to<br>port th=
e new uboot for my custom boad.<br>whether the current problem is related t=
o uboot ? One more point, previously
<br>i tried 2.6.21 with the same uboot(1.1.6) we got linux prompt but we fa=
ce<br>some issue in the pci express in that version. so we plan to upgrade =
the<br>kernel version.<br>by<br>Sivaji<br><br>Kumar Gala-3 wrote:<br>&gt;
<br>&gt;<br>&gt; On Sep 12, 2007, at 11:52 PM, sivaji wrote:<br>&gt;<br>&gt=
;&gt;<br>&gt;&gt;<br>&gt;&gt; Hi,<br>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I tired to move the dtb to 0x2000000, but th=
e result was<br>&gt;&gt; same.<br>&gt;&gt; uboot version is=20
1.1.6<br>&gt;<br>&gt; seems like a pretty old u-boot.&nbsp;&nbsp;Willing to=
 try a 1.3.0-rc1?<br>&gt;<br>&gt; - k<br>&gt; _____________________________=
__________________<br>&gt; Linuxppc-dev mailing list<br>&gt; <a href=3D"mai=
lto:Linuxppc-dev@ozlabs.org">
Linuxppc-dev@ozlabs.org</a><br>&gt; <a href=3D"https://ozlabs.org/mailman/l=
istinfo/linuxppc-dev">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><=
br>&gt;<br>&gt;<br><br>--<br>View this message in context: <a href=3D"http:=
//www.nabble.com/2.6.23-rc3-boot-hang-on-MPC8641D-tf4433508.html#a12648913"=
>
http://www.nabble.com/2.6.23-rc3-boot-hang-on-MPC8641D-tf4433508.html#a1264=
8913</a><br>Sent from the linuxppc-dev mailing list archive at <a href=3D"h=
ttp://Nabble.com">Nabble.com</a>.<br><br><br><br>--------------------------=
----
<br><br>Message: 3<br>Date: Thu, 13 Sep 2007 15:29:32 +1000<br>From: David =
Gibson &lt;<a href=3D"mailto:david@gibson.dropbear.id.au">david@gibson.drop=
bear.id.au</a>&gt;<br>Subject: Re: 2.6.23-rc3 boot hang on MPC8641D<br>To: =
sivaji &lt;
<a href=3D"mailto:rameshmrm@gmail.com">rameshmrm@gmail.com</a>&gt;<br>Cc: <=
a href=3D"mailto:linuxppc-dev@ozlabs.org">linuxppc-dev@ozlabs.org</a><br>Me=
ssage-ID: &lt;<a href=3D"mailto:20070913052932.GF14905@localhost.localdomai=
n">
20070913052932.GF14905@localhost.localdomain</a>&gt;<br>Content-Type: text/=
plain; charset=3Dus-ascii<br><br>On Wed, Sep 12, 2007 at 10:24:22PM -0700, =
sivaji wrote:<br>&gt;<br>&gt;<br>&gt; Hi,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; I am not willing to upgrade the uboot. Becuase it ta=
kes some time to
<br>&gt; port the new uboot for my custom boad.<br>&gt; whether the current=
 problem is related to uboot ? One more point, previously<br>&gt; i tried 2=
.6.21 with the same uboot(1.1.6) we got linux prompt but we face<br>&gt; so=
me issue in the pci express in that version. so we plan to upgrade the
<br>&gt; kernel version.<br><br>I thought u-boot &lt; 1.3 didn&#39;t unders=
tand the flat tree at all.&nbsp;&nbsp;In<br>which case you&#39;ll need a cu=
boot zImage.<br><br>--<br>David Gibson&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;| I&#39;ll have my music baroque, and my code
<br>david AT <a href=3D"http://gibson.dropbear.id.au">gibson.dropbear.id.au=
</a>&nbsp;&nbsp;| minimalist, thank you.&nbsp;&nbsp;NOT _the_ _other_<br>&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| _way_ _around_!<br><a href=3D"htt=
p://www.ozlabs.org/~dgibson">http://www.ozlabs.org/~dgibson
</a><br><br><br>------------------------------<br><br>Message: 4<br>Date: W=
ed, 12 Sep 2007 22:32:24 -0700 (PDT)<br>From: sivaji &lt;<a href=3D"mailto:=
rameshmrm@gmail.com">rameshmrm@gmail.com</a>&gt;<br>Subject: RE: 2.6.23-rc3
 boot hang on MPC8641D<br>To: <a href=3D"mailto:linuxppc-dev@ozlabs.org">li=
nuxppc-dev@ozlabs.org</a><br>Message-ID: &lt;<a href=3D"mailto:12648963.pos=
t@talk.nabble.com">12648963.post@talk.nabble.com</a>&gt;<br>Content-Type: t=
ext/plain; charset=3Dus-ascii
<br><br><br>Hi,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;Sorry i specify the wrong version, we r using 1.2.0. This uboot<br>was =
taken from the BSP which was released by Freescale. Previously we tested<br=
>linux 2.6.21 kernel, we got linux prompt. For this we are using the same
<br>uboot(1.2.0).<br>In that version we face some issues in the pci express=
, at that time kumar<br>suggest to upgrade the kernel verison 2.6.23-rc3.<b=
r>Zhang did u suspect the problem is related to uboot?.<br>by<br>sivaji
<br><br><br>Zhang Wei-r63237 wrote:<br>&gt;<br>&gt; Yes, It&#39;s too old. =
Maybe not fully supports FDT. You can try the version<br>&gt; of Kumar said=
 or in the BSP of Freescale released.<br>&gt;<br>&gt; - zw<br>&gt;<br>&gt;&=
gt; -----Original Message-----
<br>&gt;&gt; From: linuxppc-dev-bounces+wei.zhang=3D<a href=3D"mailto:frees=
cale.com@ozlabs.org">freescale.com@ozlabs.org</a><br>&gt;&gt; [mailto:<a hr=
ef=3D"mailto:linuxppc-dev-bounces+wei.zhang=3Dfreescale.com@ozlabs.or">linu=
xppc-dev-bounces+wei.zhang=3Dfreescale.com@ozlabs.or
</a><br>&gt;&gt; g] On Behalf Of Kumar Gala<br>&gt;&gt; Sent: Thursday, Sep=
tember 13, 2007 1:11 PM<br>&gt;&gt; To: sivaji<br>&gt;&gt; Cc: <a href=3D"m=
ailto:linuxppc-dev@ozlabs.org">linuxppc-dev@ozlabs.org</a><br>&gt;&gt; Subj=
ect: Re:=20
2.6.23-rc3 boot hang on MPC8641D<br>&gt;&gt;<br>&gt;&gt;<br>&gt;&gt; On Sep=
 12, 2007, at 11:52 PM, sivaji wrote:<br>&gt;&gt;<br>&gt;&gt; &gt;<br>&gt;&=
gt; &gt;<br>&gt;&gt; &gt; Hi,<br>&gt;&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I tired to move the dtb to 0x2000000, but t=
he result was
<br>&gt;&gt; &gt; same.<br>&gt;&gt; &gt; uboot version is 1.1.6<br>&gt;&gt;=
<br>&gt;&gt; seems like a pretty old u-boot.&nbsp;&nbsp;Willing to try a 1.=
3.0-rc1?<br>&gt;&gt;<br>&gt;&gt; - k<br>&gt;&gt; __________________________=
_____________________
<br>&gt;&gt; Linuxppc-dev mailing list<br>&gt;&gt; <a href=3D"mailto:Linuxp=
pc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a><br>&gt;&gt; <a href=3D"https=
://ozlabs.org/mailman/listinfo/linuxppc-dev">https://ozlabs.org/mailman/lis=
tinfo/linuxppc-dev
</a><br>&gt;&gt;<br>&gt; _______________________________________________<br=
>&gt; Linuxppc-dev mailing list<br>&gt; <a href=3D"mailto:Linuxppc-dev@ozla=
bs.org">Linuxppc-dev@ozlabs.org</a><br>&gt; <a href=3D"https://ozlabs.org/m=
ailman/listinfo/linuxppc-dev">
https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br>&gt;<br>&gt;<br><br=
>--<br>View this message in context: <a href=3D"http://www.nabble.com/2.6.2=
3-rc3-boot-hang-on-MPC8641D-tf4433508.html#a12648963">http://www.nabble.com=
/2.6.23-rc3-boot-hang-on-MPC8641D-tf4433508.html#a12648963
</a><br>Sent from the linuxppc-dev mailing list archive at <a href=3D"http:=
//Nabble.com">Nabble.com</a>.<br><br><br><br>------------------------------=
<br><br>Message: 5<br>Date: Thu, 13 Sep 2007 00:58:18 -0500<br>From: Kumar =
Gala &lt;
<a href=3D"mailto:galak@kernel.crashing.org">galak@kernel.crashing.org</a>&=
gt;<br>Subject: Re: Linuxppc-dev Digest, Vol 37, Issue 84<br>To: &quot;laks=
hminarayana babu&quot; &lt;<a href=3D"mailto:babu.pci81@gmail.com">babu.pci=
81@gmail.com
</a>&gt;<br>Cc: Olof Johansson &lt;<a href=3D"mailto:olof@lixom.net">olof@l=
ixom.net</a>&gt;, <a href=3D"mailto:linuxppc-dev@ozlabs.org">linuxppc-dev@o=
zlabs.org</a><br>Message-ID: &lt;<a href=3D"mailto:93B3AC37-A4E7-46BD-8484-=
F074911A9A44@kernel.crashing.org">
93B3AC37-A4E7-46BD-8484-F074911A9A44@kernel.crashing.org</a>&gt;<br>Content=
-Type: text/plain; charset=3DUS-ASCII; delsp=3Dyes; format=3Dflowed<br><br>=
<br>On Sep 13, 2007, at 12:23 AM, lakshminarayana babu wrote:<br><br>&gt; s=
ir,
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;can you plese suggest any book for pci driv=
er writing...At<br>&gt; present i am studying linux device drivers by alexa=
ndrorubini<br><br>That&#39;s about as good as it gets.&nbsp;&nbsp;It covers=
 writing a pci driver in<br>
there.<br><br>- k<br><br><br>------------------------------<br><br>Message:=
 6<br>Date: Thu, 13 Sep 2007 15:59:32 +1000<br>From: Michael Ellerman &lt;<=
a href=3D"mailto:michael@ellerman.id.au">michael@ellerman.id.au</a>&gt;<br>
Subject: Re: 2.6.23-rc3 boot hang on MPC8641D<br>To: Kumar Gala &lt;<a href=
=3D"mailto:galak@kernel.crashing.org">galak@kernel.crashing.org</a>&gt;<br>=
Cc: <a href=3D"mailto:linuxppc-dev@ozlabs.org">linuxppc-dev@ozlabs.org</a>,=
 sivaji &lt;
<a href=3D"mailto:rameshmrm@gmail.com">rameshmrm@gmail.com</a>&gt;<br>Messa=
ge-ID: &lt;<a href=3D"mailto:1189663172.20396.1.camel@concordia.ozlabs.ibm.=
com">1189663172.20396.1.camel@concordia.ozlabs.ibm.com</a>&gt;<br>Content-T=
ype: text/plain; charset=3D&quot;us-ascii&quot;
<br><br>On Thu, 2007-09-13 at 00:13 -0500, Kumar Gala wrote:<br>&gt; On Sep=
 12, 2007, at 11:47 PM, sivaji wrote:<br>&gt;<br>&gt; &gt;<br>&gt; &gt;<br>=
&gt; &gt; Hi,<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; I have JTAG Debugger connected to the board. I was given the
<br>&gt; &gt; following commands in the root path of the kernel source<br>&=
gt;<br>&gt; If you can dump memory w/o connecting GDB, I suggest the follow=
ing.<br>&gt;<br>&gt; Look in your kernel build for System.map and grep for =
log_buf you
<br>&gt; should get something like:<br>&gt;<br>&gt; c040b04c d log_buf<br>&=
gt; c043b1a4 b __log_buf<br>&gt;<br>&gt; then dump the memory @ these addre=
sses.&nbsp;&nbsp;I can&#39;t remember which one<br>&gt; is the correct one.=
&nbsp;&nbsp;You&#39;ll want to subtract c000_0000 from the
<br>&gt; address to get a physical address that you can dump.&nbsp;&nbsp;Th=
is should<br>&gt; help provide some possible insight into what&#39;s going =
on.<br><br>__log_buf is the actual buffer, log_buf points to the current in=
sertion
<br>point IIRC. It should be pretty obvious that you&#39;re looking at a dm=
esg<br>buffer though, unless there&#39;s nothing in there for some reason.<=
br><br>cheers<br><br>--<br>Michael Ellerman<br>OzLabs, IBM Australia Develo=
pment Lab
<br><br>wwweb: <a href=3D"http://michael.ellerman.id.au">http://michael.ell=
erman.id.au</a><br>phone: +61 2 6212 1183 (tie line 70 21183)<br><br>We do =
not inherit the earth from our ancestors,<br>we borrow it from our children=
. -=20
S.M.A.R.T Person<br>-------------- next part --------------<br>A non-text a=
ttachment was scrubbed...<br>Name: not available<br>Type: application/pgp-s=
ignature<br>Size: 189 bytes<br>Desc: This is a digitally signed message par=
t
<br>Url : <a href=3D"http://ozlabs.org/pipermail/linuxppc-dev/attachments/2=
0070913/30f05247/attachment-0001.pgp">http://ozlabs.org/pipermail/linuxppc-=
dev/attachments/20070913/30f05247/attachment-0001.pgp</a><br><br>----------=
--------------------
<br><br>Message: 7<br>Date: Thu, 13 Sep 2007 16:22:01 +1000<br>From: David =
Gibson &lt;<a href=3D"mailto:david@gibson.dropbear.id.au">david@gibson.drop=
bear.id.au</a>&gt;<br>Subject: Make mpc82xx use generic_calibrate_decr()<br=
>
To: Kumar Gala &lt;<a href=3D"mailto:galak@kernel.crashing.org">galak@kerne=
l.crashing.org</a>&gt;,&nbsp;&nbsp;&nbsp;&nbsp; Tony Breeds<br>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;<a href=3D"mailto:tony@bakeyournood=
le.com">tony@bakeyournoodle.com</a>&gt;, <a href=3D"mailto:linuxppc-dev@ozl=
abs.org">
linuxppc-dev@ozlabs.org</a><br>Message-ID: &lt;<a href=3D"mailto:2007091306=
2201.GA24281@localhost.localdomain">20070913062201.GA24281@localhost.locald=
omain</a>&gt;<br>Content-Type: text/plain; charset=3Dus-ascii<br><br>The on=
ly difference between m82xx_calibrate_decr() and
<br>generic_calibrate_decr() is that the former computes the timebase<br>fr=
equency from the cpu node&#39;s bus-frequency property, instead of<br>direc=
tly from the timebase-frequency property.<br><br>But there&#39;s no reason =
the timebase-frequency shouldn&#39;t be correct on
<br>82xx like everything else.&nbsp;&nbsp;Certainly the 82xx bootwrapper in=
<br>arch/powerpc/boot/cuboot-pq2.c should get it right.<br><br>Therefore, t=
his patch removes mpc82xx_calibrate_decr(), using<br>generic_calibrate_decr=
() instead.
<br><br>Signed-off-by: David Gibson &lt;<a href=3D"mailto:david@gibson.drop=
bear.id.au">david@gibson.dropbear.id.au</a>&gt;<br>---<br><br>I&#39;ve comp=
iled this, but no booted it, since I don&#39;t have any 82xx<br>hardware.&n=
bsp;&nbsp;I&#39;m hoping for an ack from someone who can test boot it.
<br><br>Index: working-2.6/arch/powerpc/platforms/82xx/mpc82xx_ads.c<br>=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>--- working-2.6.orig/ar=
ch/powerpc/platforms/82xx/mpc82xx_ads.c&nbsp;&nbsp;2007-09-13 16:14:
18.000000000 +1000<br>+++ working-2.6/arch/powerpc/platforms/82xx/mpc82xx_a=
ds.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2007-09-13 16:14:38.000000000 +100=
0<br>@@ -635,6 +635,6 @@ define_machine(mpc82xx_ads)<br>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.init_IRQ =3D&nbsp;&nbsp;&nbsp;&nbsp;mpc82xx_a=
ds_pic_init,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.show_cpuinfo =3D&nbsp;&nbs=
p;&nbsp;&nbsp;mpc82xx_ads_show_cpuinfo,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;.get_irq =3D&nbsp;&nbsp;&nbsp;&nbsp;cpm2_get_irq,<br>-&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .calibrate_decr =3D&nbsp;&nbsp;&nbsp;&nbsp;=
m82xx_calibrate_decr,<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .calibrate_d=
ecr =3D generic_calibrate_decr,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;.restart =3D m82xx_restart,.halt =3D m82xx_halt,
<br> };<br>Index: working-2.6/arch/powerpc/platforms/82xx/mpc82xx.c<br>=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>--- working-2.6.orig/ar=
ch/powerpc/platforms/82xx/mpc82xx.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2007=
-09-13 16:13:
48.000000000 +1000<br>+++ working-2.6/arch/powerpc/platforms/82xx/mpc82xx.c=
&nbsp;&nbsp; 2007-09-13 16:15:13.000000000 +1000<br>@@ -51,42 +51,6 @@<br><=
br> #include &quot;pq2ads.h&quot;<br><br>-static int __init get_freq(char *=
name, unsigned long *val)
<br>-{<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_node *cpu;<br=
>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const unsigned int *fp;<br>-&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; int found =3D 0;<br>-<br>-&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* The cpu node should have timebase and clock frequency p=
roperties */<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu =3D of_find_node_=
by_type(NULL, &quot;cpu&quot;);
<br>-<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cpu) {<br>-&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fp =
=3D of_get_property(cpu, name, NULL);<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fp) {<br>-&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; found =3D 1;<br>-&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *val =3D *fp;<br>-&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; }<br>-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; of_node_put(cpu);<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>=
-<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return found;<br>-}<br>-<br>-voi=
d __init m82xx_calibrate_decr(void)<br>-{<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ppc_tb_freq =3D 125000000;<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 if (!get_freq(&quot;bus-frequency&quot;, &amp;ppc_tb_freq)) {
<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; printk(KERN_ERR &quot;WARNING: Estimating decrementer freque=
ncy &quot;<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;(not found)\n&quot;);<b=
r>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ppc_tb_freq /=3D 4;<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ppc_pr=
oc_freq =3D 1000000000;
<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!get_freq(&quot;clock-frequen=
cy&quot;, &amp;ppc_proc_freq))<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_ERR &quot;WARNING:=
 Estimating processor frequency&quot;<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &q=
uot;(not found)\n&quot;);
<br>-}<br>-<br> void mpc82xx_ads_show_cpuinfo(struct seq_file *m)<br> {<br>=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;uint pvid, svid, phid1;<br>=
<br>--<br>David Gibson&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| I&#39;=
ll have my music baroque, and my code<br>david AT <a href=3D"http://gibson.=
dropbear.id.au">
gibson.dropbear.id.au</a>&nbsp;&nbsp;| minimalist, thank you.&nbsp;&nbsp;NO=
T _the_ _other_<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| _way_ _aroun=
d_!<br><a href=3D"http://www.ozlabs.org/~dgibson">http://www.ozlabs.org/~dg=
ibson</a><br><br><br>------------------------------
<br><br>Message: 8<br>Date: Thu, 13 Sep 2007 01:39:58 -0500<br>From: Kumar =
Gala &lt;<a href=3D"mailto:galak@kernel.crashing.org">galak@kernel.crashing=
.org</a>&gt;<br>Subject: Re: [PATCH 10/10] mpc82xx: Add pq2fads board suppo=
rt.
<br>To: Scott Wood &lt;<a href=3D"mailto:scottwood@freescale.com">scottwood=
@freescale.com</a>&gt;<br>Cc: <a href=3D"mailto:linuxppc-dev@ozlabs.org">li=
nuxppc-dev@ozlabs.org</a><br>Message-ID: &lt;<a href=3D"mailto:9BC5B02A-4E9=
D-42DD-90C3-F8C3382F2A96@kernel.crashing.org">
9BC5B02A-4E9D-42DD-90C3-F8C3382F2A96@kernel.crashing.org</a>&gt;<br>Content=
-Type: text/plain; charset=3DUS-ASCII; delsp=3Dyes; format=3Dflowed<br><br>=
&gt; diff --git a/arch/powerpc/boot/dts/pq2fads.dts b/arch/powerpc/boot/<br=
>&gt; dts/pq2fads.dts
<br>&gt; new file mode 100644<br>&gt; index 0000000..ad736f8<br>&gt; --- /d=
ev/null<br>&gt; +++ b/arch/powerpc/boot/dts/pq2fads.dts<br>&gt; @@ -0,0 +1,=
236 @@<br>&gt; +/*<br>&gt; + * Device Tree for the PQ2FADS-ZU board with an=
 MPC8280 chip.
<br>&gt; + *<br>&gt; + * Copyright 2007 Freescale Semiconductor Inc.<br>&gt=
; + *<br>&gt; + * This program is free software; you can redistribute&nbsp;=
&nbsp;it and/or<br>&gt; modify it<br>&gt; + * under&nbsp;&nbsp;the terms of=
&nbsp;&nbsp;the GNU General&nbsp;&nbsp;Public License as
<br>&gt; published by the<br>&gt; + * Free Software Foundation;&nbsp;&nbsp;=
either version 2 of the&nbsp;&nbsp;License, or<br>&gt; (at your<br>&gt; + *=
 option) any later version.<br>&gt; + */<br>&gt; +<br>&gt; +/ {<br>&gt; +&n=
bsp;&nbsp;&nbsp;&nbsp; model =3D &quot;pq2fads&quot;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D &quot;fsl,pq2fads&quot;;<=
br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =3D &lt;1&gt;;<br>&gt; +&n=
bsp;&nbsp;&nbsp;&nbsp; #size-cells =3D &lt;1&gt;;<br>&gt; +<br>&gt; +&nbsp;=
&nbsp;&nbsp;&nbsp; cpus {<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =3D &lt;1&gt;;<br>&gt; +&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size=
-cells =3D &lt;0&gt;;
<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; cpu@0 {<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; device_type =3D &quot;cpu&quot;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; reg =3D &lt;0&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; d-cache-line-size =3D &lt;d#32&gt;;<br>&gt; +&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i-cache-line-size =3D &lt;d#32&gt;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d-cache-size =3D &l=
t;d#16384&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i-cac=
he-size =3D &lt;d#16384&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; timebase-frequency =3D &lt;0&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; clock-frequency =3D &lt;0&gt;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; };<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp; };<br>&gt; +<br>&gt; +&nbsp;&n=
bsp;&nbsp;&nbsp; CS: chipselect {<br><br>We need to document this in bootin=
g-without-of.<br><br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D &quot;fsl,pq2fads-chipselect&quot;,=
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&quot;fsl,mpc8280-chipselect&quot;,
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&quot;fsl,pq2-chipselect&quot;;<br>&gt; +&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =3D &=
lt;2&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; #size-cells =3D &lt;1&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fsl,ctrl =3D &lt;&amp;CS=
CTRL&gt;;<br>
&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; ranges =3D &lt;0 0 fe000000 00800000<br>&gt; +&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 0 f4500000 00008000<br>&gt; +&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8 0 f8200000 00008=
000&gt;;<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; flash@0,0 {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type =3D &quot;r=
om&quot;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible=
 =3D &quot;direct-mapped&quot;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; reg =3D &lt;0 0 800000&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; probe-type =3D &quot;JEDEC&quot;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bank-width =3D &lt;=
4&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; };<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bcsr@1,0 {<br>&gt; +&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;1 0 20&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D &quot;fsl,pq2fads-bcsr&quot;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; };<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; PCI_PIC: pic@8,0 {<br>&gt; +&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; #interrupt-cells =3D &lt;1&gt;;<br>&gt; +&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-controller;<br>&gt; +&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;8 0 8&gt;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D &quo=
t;fsl,pq2ads-pci-pic&quot;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; interrupt-parent =3D &lt;&amp;PIC&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; interrupts =3D &lt;18 8&gt;;<br>&gt; +&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp; };<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp;=
&nbsp; memory {<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; device_type =3D &quot;memory&quot;;<br>&gt; +&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &=
lt;0 0&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp; };<br>&gt; +<br>&gt; +&nbsp;&=
nbsp;&nbsp;&nbsp; soc@f0000000 {<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =3D &lt;1&gt;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; #size-cells =3D &lt;1&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type =3D &quot;soc&quot;;<=
br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; compatible =3D &quot;fsl,mpc8280&quot;, &quot;fsl,pq2-soc&quot;;<br>=
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ranges =3D &lt;00000000 f0000000 00053000
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8000000=
0 80000000 40000000<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; f6000000 f6000000 02000000&gt;;<br>&gt; +<br>&gt; +&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CSCTRL: chipse=
lect {<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =
=3D &quot;fsl,mpc8280-chipselect-ctrl&quot;,
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&quot;fsl,p=
q2-chipselect-ctrl&quot;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; reg =3D &lt;10100 60&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; fsl,bus =3D &lt;&amp;CS&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>&gt; +
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; cpm@119c0 {<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
#address-cells =3D &lt;1&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; #size-cells =3D &lt;1&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; #interrupt-cells =3D &lt;2&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D &quot;fsl,mpc8280-cpm&quot;, &q=
uot;fsl,cpm2&quot;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;119c0 3=
0 0 2000&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges=
;<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; brg@119f=
0 {<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D &quot;fsl,mpc8280-brg&quot;,
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&quot;fsl,cpm2-brg&quot;,<br>&gt; +&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&quot;fsl,cpm-brg&quot;;<br>&gt; +&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; reg =3D &lt;119f0 10 115f0 10&gt;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>&gt; +<br>&gt=
; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; serial@11a00 {<br>&gt; +&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; device_type =3D &quot;serial&quot;;<br>&gt; +&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; compatible =3D &quot;fsl,mpc8280-scc-uart&quot;,
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&quot;fsl,cpm2-scc-uart&quot;;<br>&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; reg =3D &lt;11a00 20 8000 100&gt;;<br>&gt; +&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; interrupts =3D &lt;28 8&gt;;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; interrupt-parent =3D &lt;&amp;PIC&gt;;<br>&gt; +&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; fsl,cpm-brg =3D &lt;1&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fsl=
,cpm-command =3D &lt;00800000&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; };
<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; serial@11=
a20 {<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type =3D &quot;serial&quot;;<br>&g=
t; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; compatible =3D &quot;fsl,mpc8280-scc-uart&quot;,<br>=
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&quot;fsl,cpm2-scc-uart&quot;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;11a20 20 8100 100&gt;;<br>&gt; +&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; interrupts =3D &lt;29 8&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
nterrupt-parent =3D &lt;&amp;PIC&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fsl,cpm-b=
rg =3D &lt;2&gt;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; fsl,cpm-command =3D &lt;04a00000&gt;;<br>&gt; =
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>&gt; +<br>&gt; +&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ethernet@11320 {<br>&gt; +&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; device_type =3D &quot;network&quot;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D &quot;fsl,mpc8280-fcc-enet&quot=
;,<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&quot;fsl,cpm2-fcc-enet&quot;;<br>&g=
t; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;11320 20 8500 100 113b0 1&gt;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts =3D &lt;21 8&gt;;<br>&gt; +&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; interrupt-parent =3D &lt;&amp;PIC&gt;;<br>&gt; +&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; phy-handle =3D &lt;&amp;PHY0&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; linux,netw=
ork-index =3D &lt;0&gt;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; fsl,cpm-command =3D &lt;16200300&gt;;<br>&gt; =
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>&gt; +<br>&gt; +&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ethernet@11340 {<br>&gt; +&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; device_type =3D &quot;network&quot;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D &quot;fsl,mpc8280-fcc-enet&quot=
;,<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&quot;fsl,cpm2-fcc-enet&quot;;<br>&g=
t; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;11340 20 8600 100 113d0 1&gt;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts =3D &lt;22 8&gt;;<br>&gt; +&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; interrupt-parent =3D &lt;&amp;PIC&gt;;<br>&gt; +&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; phy-handle =3D &lt;&amp;PHY1&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; linux,netw=
ork-index =3D &lt;1&gt;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; fsl,cpm-command =3D &lt;1a400300&gt;;<br>&gt; =
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; local-mac-address =3D [00 e0 0c 00 79 01];<br>&gt; +&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>&gt; +<br>&gt; +&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
mdio@10d40 {<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type =3D &quot;mdio&quot;;<=
br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D &quot;fsl,pq2fads-mdio-bitbang&q=
uot;,<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&quot;fsl,mpc8280-mdio-bitbang&qu=
ot;,
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&quot;fsl,cpm2-mdio-bitbang&quot;;<br>=
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =3D &lt;1&gt;;<br>&gt; +&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; #size-cells =3D &lt;0&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;=
10d40 14&gt;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; fsl,mdio-pin =3D &lt;9&gt;;<br>&gt; +&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; fsl,mdc-pin =3D &lt;a&gt;;<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
PHY0: ethernet-phy@0 {<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; interrupt-parent =3D &lt;&amp;PIC&gt;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; interrupts =3D &lt;19 2&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;0&gt;;<br>&gt; +&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type =3D &quot;e=
thernet-phy&quot;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHY1:=
 ethernet-phy@1 {<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; interrupt-parent =3D &lt;&amp;PIC&gt;;<br>&gt; +&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts =3D &=
lt;19 2&gt;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; reg =3D &lt;3&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; device_type =3D &quot;ethernet-phy&quot;;<br>&gt; +&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; };<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
};
<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; usb@11b60=
 {<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =3D &lt;1&gt;;<br>&gt; +&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; #size-cells =3D &lt;0&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compat=
ible =3D &quot;fsl,mpc8280-usb&quot;,
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&quot;fsl,cpm2-usb&quot;;<br>&gt; +&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; reg =3D &lt;11b60 18 8b00 100&gt;;<br>&gt; +&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; interrupt-parent =3D &lt;&amp;PIC&gt;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts =3D &lt;b 8&gt;;<br>&gt; +&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; fsl,cpm-command =3D &lt;2e600000&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PIC:=20
interrupt-controller@10c00 {<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; #interrupt-cells =3D &lt;2&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; interrupt-controller;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;10c00 80&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D &quot;fsl,mpc8280-pic&quot;, &q=
uot;fsl,pq2-pic&quot;;
<br><br>this should also have a &quot;fsl,cpm2-pic&quot; or something of th=
at form.<br>(exact same pic exists on 8560, 85xx+CPM)<br><br>&gt; +&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>&gt;=
 +<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; pci@10800 {<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; device_type =3D &quot;pci&quot;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;10800 1=
0c 101ac 8 101c4 8&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; compatible =3D &quot;fsl,mpc8280-pci&quot;, &quot;fsl,pq2-pci&quot;;<br=
>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #interrupt-cells =3D &=
lt;1&gt;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells =3D &lt=
;2&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cel=
ls =3D &lt;3&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cl=
ock-frequency =3D &lt;d#66000000&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; interrupt-map-mask =3D &lt;f800 0 0 7&gt;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-map =3D &=
lt;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* IDSEL 0x16 */<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b000 0 0 1 &amp;PCI_PIC 0<br>&gt; +&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b00=
0 0 0 2 &amp;PCI_PIC 1
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;b000 0 0 3 &amp;PCI_PIC 2<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b000 0 0 4 &amp;PCI_PIC =
3<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; /* IDSEL 0x17 */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;b800 0 0 1 &amp;PCI_PIC 4<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b800 0 0 2 &amp;PCI_PIC 5<br=
>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;b800 0 0 3 &amp;PCI_PIC 6<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b800 0 0 4 &amp;PCI_PIC 7
<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* IDSEL 0x18 */<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;c000 0 0 1 &amp;PCI_PIC 8<br>&gt; =
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;c000 0 0 2 &amp;PCI_PIC 9<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;c000 0 0 3 &amp;PCI_PIC a<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;c000 0 0 4 &amp;PCI_PIC b&gt=
;;<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interru=
pt-parent =3D &lt;&amp;PIC&gt;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts =3D &lt;=
12 8&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges =3D=
 &lt;42000000 0 80000000 80000000 0 20000000<br>&gt; +&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 02000000 0 a0000000 a0000000 0 20000000<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 01000000 0 00000000 f6000000 0 0200000=
0&gt;;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; };<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp; };<br>&gt; +<br>&gt; +&n=
bsp;&nbsp;&nbsp;&nbsp; chosen {<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; linux,stdout-path =3D &quot;/soc/cpm=
/serial@11a00&quot;;
<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp; };<br>&gt; +};<br><br>- k<br><br><br><br=
><br>------------------------------<br><br>________________________________=
_______________<br>Linuxppc-dev mailing list<br><a href=3D"mailto:Linuxppc-=
dev@ozlabs.org">Linuxppc-dev@ozlabs.org
</a><br><a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev">https:=
//ozlabs.org/mailman/listinfo/linuxppc-dev</a><br><br>End of Linuxppc-dev D=
igest, Vol 37, Issue 87<br>********************************************<br>
</blockquote></div><br>

------=_Part_2499_19661013.1189805525257--
