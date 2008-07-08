Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C88ACDDDE7
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 14:58:49 +1000 (EST)
Subject: Re: [PATCH] powerpc: rework 4xx PTE access and TLB miss
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080707212523.24d2014f@zod.rchland.ibm.com>
References: <20080701043607.07484DDED7@ozlabs.org>
	<20080707100627.4be05488@zod.rchland.ibm.com>
	<1215468180.8970.124.camel@pasglop>
	<20080707212523.24d2014f@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Tue, 08 Jul 2008 14:58:33 +1000
Message-Id: <1215493113.8970.199.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > I'll have a look.
> 
> Cool, thanks.  If I get some time, I'll poke around myself too.

Ok, I had no problem with my small initrd setup, strangely enough,
but I did reproduce something similar to what you describe with NFS
root on another machine.

I'll dig.

Cheers,
Ben.
