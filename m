Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CC818DDE3A
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 07:55:42 +1100 (EST)
Subject: Re: [PATCH 2/6] ibm_newemac: Add ET1011c PHY support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071108060805.4c59b579@zod.rchland.ibm.com>
References: <20071108080729.E09F7DDDFB@ozlabs.org>
	<200711080941.46894.sr@denx.de> <1194511344.6561.0.camel@pasglop>
	<20071108060805.4c59b579@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Fri, 09 Nov 2007 07:55:21 +1100
Message-Id: <1194555321.6561.4.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-11-08 at 06:08 -0600, Josh Boyer wrote:
> > Agreed, I though I had removed them, looks like I didn't. Will fix
> that
> > before submitting.
> 
> DENX is pretty good about having Signed-off-by lines in their tree...
> maybe you should add the original authors as well if it's there.

I picked it up from an already patched tree. Stefan, can you provide me
the proper SOB ?

Thanks,
Ben.
