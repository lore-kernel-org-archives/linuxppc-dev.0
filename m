Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id DABE2DE114
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 20:14:09 +1000 (EST)
Message-ID: <480722E0.2010609@scram.de>
Date: Thu, 17 Apr 2008 12:13:52 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH] powerpc: Implement GPIO LIB API on CPM2 Freescale SoC.
References: <200804171148.11593.laurentp@cse-semaphore.com>
In-Reply-To: <200804171148.11593.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=ISO-8859-1
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

> This patch implement GPIO LIB support for the CPM2 GPIOs.
> 
> The code is based on Jochen Friedrich's patch for the CPM1.

I guess most of this should go to cpm_common.c and should be used for
Port E on CPM1, as well. This port uses the same layout as CPM2 while 
Port B uses a different layout. See the discussion in
http://patchwork.ozlabs.org/linuxppc/patch?id=16282

Thanks,
Jochen
