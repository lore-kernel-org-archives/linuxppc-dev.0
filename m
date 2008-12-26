Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3CCD0DDDCA
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Dec 2008 08:23:21 +1100 (EST)
Subject: Re: [PATCH] powerpc: add 16K/64K pages support for the 44x PPC32
	architectures.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20081224170359.GA22129@zod.rchland.ibm.com>
References: <49406F61.2000004@emcraft.com>
	<1228960541-11407-1-git-send-email-yanok@emcraft.com>
	<20081217195607.GE3049@localhost.localdomain>
	<20081224170359.GA22129@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Sat, 27 Dec 2008 08:22:55 +1100
Message-Id: <1230326575.7292.41.camel@pasglop>
Mime-Version: 1.0
Cc: Ilya Yanok <yanok@emcraft.com>, dzu@denx.de, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Vladimir Panfilov <pvr@emcraft.com>, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> >The code looks pretty clean now.  I think if we're going to include
> >this patch it should go in now.
> >
> >Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> 
> Ben, Paul,
> 
> What else is needed to get this patch included?

Can you remind us the pre-req ?

Cheers,
Ben.
