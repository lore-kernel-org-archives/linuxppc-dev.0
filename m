Return-Path: <stefan.nickl@kontron.com>
Received: from kom-mail1.kontron-modular.com (unknown [62.159.155.196])
	by ozlabs.org (Postfix) with ESMTP id BBBEA2BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Oct 2004 00:47:33 +1000 (EST)
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <EE71B8E2-29B5-11D9-952E-000393DBC2E8@freescale.com>
References: <1099054203.10741.13.camel@lucy.pep-kaufbeuren.de>
	<EE71B8E2-29B5-11D9-952E-000393DBC2E8@freescale.com>
Content-Type: text/plain
Date: Fri, 29 Oct 2004 16:47:31 +0200
Message-Id: <1099061251.10766.28.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: All-ones problem with FCC1 on MPC8541
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2004-10-29 at 09:22 -0500, Kumar Gala wrote:
> [snip]
> > We'll try to get hold of CDS eval board schematics to check more on the
> >  hardware side, in the meantime, do you have an idea of which registers
> >  to look at in particular?
> 
> Did not realize you were using a CDS, but physical ethernet port on the 
> board do you believe the FCC is hooked up to?  While, some of the 

No, sorry you got me wrong on that.
I don't have access to a CDS, we have swapped processors on some of
our EB8540 (EEBrain) modules. The board supports 8540 and 8541 since
as our hardware guy tells me, the MII lines from the 8540's FEC are N/C
on the 8541 BGA balls, as are the 8541's FCC1 lines in respect to the
8540 BGA balls.

I just assume the 8541 works on the CDS ;-), so we might spot a
helpful difference to our board's schematics.

> issues you are having in internal loopback seem to mean other problems, 
> I believe the FCCs are only available for ethernet over some additional 
> adapter add on cards.

Can you please confirm the CDS setup you describe does actually work
with linuxppc-2.4 v2.4.27_linuxppc and U-Boot built from the public CVS?


Regards,

-- 
Stefan Nickl
Kontron Modular Computers
