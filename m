Return-Path: <dan.j.williams@intel.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E0A0DB7244
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 07:36:28 +1000 (EST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by ozlabs.org (Postfix) with ESMTP id 45972DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 07:36:27 +1000 (EST)
Message-ID: <4A3AB359.40209@intel.com>
Date: Thu, 18 Jun 2009 14:36:25 -0700
From: Dan Williams <dan.j.williams@intel.com>
MIME-Version: 1.0
To: Ira Snyder <iws@ovro.caltech.edu>
Subject: Re: [RFC PATCH] fsldma: Add DMA_SLAVE support
References: <20090515225659.GD858@ovro.caltech.edu>
	<4A37EC14.5010005@intel.com>
	<20090616201256.GG15955@ovro.caltech.edu>
	<4A392542.6010306@intel.com>
	<20090617182947.GB4707@ovro.caltech.edu>
	<4A3A8463.7080601@intel.com>
	<20090618205024.GA16741@ovro.caltech.edu>
In-Reply-To: <20090618205024.GA16741@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ira Snyder wrote:
> So, I see a couple of ways of moving forward:
> 1) Keep my implementation, moving the includes to arch/powerpc/include.
>    Do we drop the allocation functions?

+1 for option 1.  Having it under arch/powerpc/include makes it clear 
that it is a powerpc specific api, so keep the allocation routines. 
Copy Kumar on the updated patch as I'll need a ppc-dev ack for carrying 
this file addition through the dmaengine tree.

> Thanks for all the input Dan. I finally feel like we're getting
> somewhere :)

Thanks for the exchange it always helps to get a good picture of the 
underlying design rationale.

Regards,
Dan
