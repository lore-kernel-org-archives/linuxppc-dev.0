Return-Path: <rsass@uncc.edu>
Received: from rsass-homer.uncc.edu (rsass-homer.uncc.edu [152.15.91.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DBB9CDDE3C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Jan 2008 11:17:33 +1100 (EST)
Message-Id: <200801190011.m0J0BCtr001286@rsass-homer.uncc.edu>
To: "Jean-Samuel Chenard" <jsamch@macs.ece.mcgill.ca>
Subject: Re: ml310 kernel2.6 booting problems 
In-reply-to: <169c03cb0801171849i59d35893hda44a7f0c5417b58@mail.gmail.com> 
References: <169c03cb0801171849i59d35893hda44a7f0c5417b58@mail.gmail.com>
Date: Fri, 18 Jan 2008 19:11:12 -0500
From: Ron Sass <rsass@uncc.edu>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello All,

I have a sidewise question related to this thread.  We have
several ML-310 and ML-410 boards.  At some point, we may need
PCI but right now it is not urgent so I am not ready to invest
a lot of time yet either.  I imagine that 2.6 + PCI would be
relatively similiar for both ML-310 and ML-410...

My question is this:  Would it make sense to have a Kernel
configuration something like "VIRTEX_PCI" and a platforms
"XILINX_ML4xx" / "XILINX_ML3xx" ... or create four platforms:

  XILINX_ML300
  XILINX_ML310
  XILINX_ML40x
  XILINX_ML410

I ask now because we are working on some device drivers for
the ML410 that may work on 40x and I wondering if I should
introduce a new ML410 platform option...

Ron

> > Date: Thu, 17 Jan 2008 21:19:04 +0100
> > From: Joachim Meyer
> > Hmmm... I'm not really ready to invest that much time into the PCI for ML=
> -310.
> > -------------------------------------------------------------------------=
> -------
> > http://ozlabs.org/pipermail/linuxppc-embedded/2007-December/029211.html
> >
> > How much work would it be (approximated), and do you think I can success =
> (I'm a novice, like you know)?
> > Would you help me (Tell me where to start & what to do)?
> 
> Hi Joachim,
> 
> I was also interested in getting the PCI to run on the ML-310.  I did
> spend an evening trying to integrate a patch sent over by Stephen
> Neuendorffer from Xilinx.  I managed to get everything to compile
> (basically I fixed a few missing macros and had to search a bit to
> ensure that the memory mapping was correctly ported).  Unfortunately,
> when I tried the new kernel, I think that I must have messed something
> up with the interrupt mappings (I am a newbie to PCI) and I had to
> remove some interrupt mapping from Stephen's patch.
> 
> In any case, my ML-310 was booting the Linux kernel, but something was
> not right and I did not get anymore printouts from the UART Lite.
> Since I don't have the JTAG cable, I was stuck at this point with
> little means to debug the system.  One day I'll spoil myself with one
> of those platform JTAG USB cables...
> 
> I used Z-modem to transfer files to/from my workstation to my CF card
> on the ML-310 and this was an acceptable compromise.
> 
> I'd still be interested in having the PCI bus working on the ML-310,
> but now that I got my BEE2 booting Linux 2.6, its not such a big
> priority for me.  Let me know if you have some success in that
> direction.
> 
> Regards,
> 
> Jean-Samuel
> -- =
> 
> Integrated Microsystems Laboratory
> McGill University, Montr=E9al, QC, CANADA
> Web Page: http://chaos.ece.mcgill.ca
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
