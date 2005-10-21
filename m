Return-Path: <rupert@ces.ch>
Received: from server1.serv-net.de (31.204.203.213.rev.inetbone.net
	[213.203.204.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 52687685ED
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Oct 2005 04:28:09 +1000 (EST)
From: Rupert Eibauer <rupert@ces.ch>
To: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 21 Oct 2005 20:43:16 +0200
References: <200510211417.49651.rupert@ces.ch>
	<200510211711.02997.rupert@ces.ch>
	<B34FF652-6E5D-437D-812C-763B2D10C7CA@freescale.com>
In-Reply-To: <B34FF652-6E5D-437D-812C-763B2D10C7CA@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510212043.18615.rupert@ces.ch>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH][RFT] please use this one
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 21 October 2005 17:23, Kumar Gala wrote:
> 
> On Oct 21, 2005, at 10:11 AM, Rupert Eibauer wrote:
> 
> > On Friday 21 October 2005 16:28, Kumar Gala wrote:
> >
> >> The concept of PPC_HIGH_BATS is already some what handled with
> >> CPU_FTR_HAS_HIGH_BATS.  I recommend you use this feature instead of
> >> introducing another one as well as a compile time option.
> >>
> >
> > CPU_FTR_HAS_HIGH_BATS only clears the high bats, but does
> > not attempt to use them. My patch will use them.
> 
> I understand, I'm suggesting you expand CPU_FTR_HAS_HIGH_BATS to  
> include your additional functionality.

How do you mean that exactly?

Do you mean making the feature always-on (not selectable in Kconfig)?
Having CONFIG_PPC_LARGE_BATS and CONFIG_HIGH_PATS always-on would
be ok for me, but for PHYS_64BIT should be left up to the platform
to decide if it should be presented to the user or not.

Do you think the other two features, CPU_FTR_BIG_PHYS and 
CPU_FTR_LARGE_BATS should be merged into one bit? They could for now, 
because there is no processor supporting only one of them.

Rupert

> 
> - kumar
