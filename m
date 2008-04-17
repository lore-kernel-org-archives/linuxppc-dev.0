Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7B0A2DDED9
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 22:49:04 +1000 (EST)
Message-ID: <4807472E.9000300@scram.de>
Date: Thu, 17 Apr 2008 14:48:46 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH] powerpc: Implement GPIO LIB API on CPM2 Freescale SoC.
References: <200804171148.11593.laurentp@cse-semaphore.com>
	<200804171311.46781.laurentp@cse-semaphore.com>
	<480732C9.9080800@scram.de>
	<200804171408.46533.laurentp@cse-semaphore.com>
In-Reply-To: <200804171408.46533.laurentp@cse-semaphore.com>
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

> Any preference for common function names ? cpm2_gpio32* might be too 
> CPM2-specific for cpm_common.c. cpm_gpio32* is a bit too generic as it 
> doesn't support port E on the CPM1.

I would keep the cpm2 name. I'll just add a comment to cpm1.c that
fsl,cpm1-pario-bank32e uses cpm2 layout.

Thanks,
Jochen
