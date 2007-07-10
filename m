Return-Path: <gmuruga@gdatech.com>
Received: from darwaza.gdatech.com (darwaza.gdatech.com [66.237.41.98])
	by ozlabs.org (Postfix) with ESMTP id 038F6DDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jul 2007 02:51:24 +1000 (EST)
Date: Tue, 10 Jul 2007 09:52:01 -0700
Message-Id: <200707101652.l6AGq1613447@sierra.gdatech.com>
From: "Muruga Ganapathy" <gmuruga@gdatech.com>
To: "Mark A. Greer" <mgreer@mvista.com>, ThomasB <psyphi@gmail.com>,
	Linuxppc-embedded@ozlabs.org
Subject: Re: [kernel-2.6.19]Marvell GT-64260 and Ethernet
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

You need to check the phy address and the type of the PHY used.
If it is not there/or supported, you may want to include them.


> On Tue, Jul 10, 2007 at 03:41:25PM +0200, ThomasB wrote:
> > >Isn't the ethernet the same on the 64260, 64360, 64460?
> > >
> > >There's definitely a driver for 6436x and above..
> > 
> > I just try it, it doesn't work, I receive without end the message:
> > mv643xx PHY read timeout, port 0
> > 
> > >I believe that Steve Hill <sjhill@realitydiluted.com> has patched
> > >the mv643xx_eth driver to work with the 64260 and plans to submit
> > >the patches.
> > That's means the patch isn't yet ready?
> 
> It probably means you don't something set up for whatever PHY you're
> using.
> 
> > I will try to contact him.
> 
> A good idea.
> 
> > It's nevertheless odd, I read about a file named gt64260_eth.c 
during my
> > search on the internet.But I wasn't able to find it :(.
> 
> There was one for 2.4 that was in the ppc devel tree but it never went
> mainline.  Hopefully, Steve can help you from here.
> 
> Mark
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

*************************************************************
GDA Technologies, Inc.		
1010 Rincon Circle 
San Jose CA, 95131
Phone	(408) 432-3090
Fax	(408) 432-3091

Accelerate Your Innovation	
**************************************************************


=====
This message contains information from GDA Technologies Inc and 
affiliates, and is intended for the sole use of the individual and 
entity to whom it is addressed. It may contain information, including 
any attachments, that is privileged, confidential and exempt from 
disclosure under applicable law. If you are not the intended addressee, 
nor authorized to receive for the intended addressee, you are hereby 
notified that you may not use, copy, disclose or distribute to anyone 
the message or any information contained in the message. If you have 
received this electronic transmission in error, please notify the 
sender immediately by a "reply to sender only" message and destroy all 
electronic and hard copies of the communication, including attachments.
====
