Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9C563DDE9C
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 01:30:35 +1100 (EST)
To: "Zhang Wei" <Wei.Zhang@freescale.com>
Subject: Re: [PATCH 1/2] Add RapidIO node into MPC8641HPCN dts file 
In-Reply-To: Your message of "Fri, 01 Feb 2008 12:51:21 +0800."
	<ABF87B0B6A38C0458E319AC973ED68AEBD08DB@zch01exm26.fsl.freescale.net>
References: <12017656032841-git-send-email-wei.zhang@freescale.com>
	<47A1F73E.3090600@freescale.com>
	<ABF87B0B6A38C0458E319AC973ED68AEBD08DB@zch01exm26.fsl.freescale.net>
Date: Fri, 01 Feb 2008 08:30:28 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JKwuS-0007fC-Aa@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day "Zhang Wei" mumbled:
> > 
> > The 8641 DTS file has been converted to /dts-v1/ format now.
> > Please rewrite this patch with explicit hex numbers for
> > addresses, even if 0x0, and decimal for IRQs.
>
> I have seen other nodes in mpc8641_hpcn.dts still use old style.
>  Is it better to create an another new patch for correcting the style all?

The file as to be all one format or the other, it can not be mixed.

Kumar applied my patches to convert all the 86xx FSL boards to /dts-v1/
and they have gone into Paul's and Linus' mainline already.

If another old style node goes by, we should all gang up on it! :-)

jdl
