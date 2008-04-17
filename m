Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 44730DE2F3
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 21:21:57 +1000 (EST)
Message-ID: <480732C9.9080800@scram.de>
Date: Thu, 17 Apr 2008 13:21:45 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH] powerpc: Implement GPIO LIB API on CPM2 Freescale SoC.
References: <200804171148.11593.laurentp@cse-semaphore.com>
	<480722E0.2010609@scram.de>
	<200804171311.46781.laurentp@cse-semaphore.com>
In-Reply-To: <200804171311.46781.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=ISO-8859-15
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Laurent,

>> http://patchwork.ozlabs.org/linuxppc/patch?id=16282
> 
> The link doesn't seem to be related.

http://patchwork.ozlabs.org/linuxppc/patch?id=17490 is the correct one. 

> I'll rework the patch to move CPM2 GPIO support to cpm_common.c. Have you 
> thought about a proper name for the compatible property ?

I would leave cpm_init_par_io() in cpm2.c and just move the other parts.
- for cpm2, the property fsl,cpm2-pario-bank is correct.
- for cpm1, i'm thinking of something like fsl,cpm1-pario-bank32b and fsl,cpm1-pario-bank32e.

I'll update the CPM1 parts on top of your patch...

Thanks,
Jochen
