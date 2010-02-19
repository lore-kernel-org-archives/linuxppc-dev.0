Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A8129B7CB9
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Feb 2010 08:55:17 +1100 (EST)
Subject: Re: [PATCH] eeh: Fixing a bug when pci structure is null
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Breno Leitao <leitao@linux.vnet.ibm.com>
In-Reply-To: <4B7EBF9A.7020801@linux.vnet.ibm.com>
References: <1264789719-15591-1-git-send-email-leitao@linux.vnet.ibm.com>
	<4B6864F4.1030106@linux.vnet.ibm.com>
	<20100202180503.GL4757@pengutronix.de>
	<4B699CB9.3030605@linux.vnet.ibm.com>
	<4B7EBF9A.7020801@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 20 Feb 2010 08:54:45 +1100
Message-ID: <1266616485.23523.1026.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Linas Vepstas <linasvepstas@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-02-19 at 14:43 -0200, Breno Leitao wrote:
> Hi Ben, 
> 
> I'd like to ask about this patch ? Should I re-submit ?
> 
> Thanks, 
> 
> Breno Leitao wrote:
> > During a EEH recover, the pci_dev structure can be null, mainly if an
> > eeh event is detected during cpi config operation. In this case, the
> > pci_dev will not be known (and will be null) the kernel will crash
> > with the following message:

It should be in -next, can you dbl check ?

Cheers,
Ben.
