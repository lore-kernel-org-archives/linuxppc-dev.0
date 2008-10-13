Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7CDB2DE2AD
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 10:46:14 +1100 (EST)
Subject: Re: [PATCH] powerpc: Add legacy PCI access via sysfs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
In-Reply-To: <200810131029.11822.jbarnes@virtuousgeek.org>
References: <20081010025101.B48CADDEF7@ozlabs.org>
	<200810101039.18300.jbarnes@virtuousgeek.org>
	<20081013140734.GA9793@yoda.jdub.homelinux.org>
	<200810131029.11822.jbarnes@virtuousgeek.org>
Content-Type: text/plain
Date: Tue, 14 Oct 2008 10:39:36 +1100
Message-Id: <1223941176.8157.290.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pci@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Is that targeted towards .28 or .29?  Ben has a 4xx specific patch
> > that depends on this one, and I just need to know which version to
> > bring that in for.
> 
> I was planning on sending it for .28.

There's a minor bogon in the powerpc side patch, ie, I left an unused
variable from an old version of the patch. No big deal, but if you
haven't merged yet, let me know and I'll do a new spin. If you have
already, I'll do a fixup later on via the powerpc.git tree.

BTW. When do you intend to send that to Linus ?

Cheers,
Ben.
