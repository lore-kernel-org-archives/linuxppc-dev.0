Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 528CFDDE05
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 02:44:08 +1000 (EST)
Subject: Re: [PATCH] Remove CPU_FTR_NEED_COHERENT for 7448.
From: Jon Loeliger <jdl@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0705101117200.6072@localhost.localdomain>
References: <1178141683.32136.46.camel@ld0161-tx32>
	<Pine.LNX.4.64.0705101117200.6072@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1178815440.6578.14.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Thu, 10 May 2007 11:44:00 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-10 at 11:17, Kumar Gala wrote:

> >
> > Remove CPU_FTR_NEED_COHERENT for MPC7448 (and single-core MPC86xx).
> > This prevents needlessly setting M=1 when not SMP.
> >
> 
> applied.
> 
> - k

Sweet.  Thanks!

jdl
