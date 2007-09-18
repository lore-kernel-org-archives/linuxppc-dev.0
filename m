Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0516DDDF56
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 07:42:34 +1000 (EST)
Subject: Re: [PATCH] [RFC][POWERPC] Merge 32 and 64 bit
	pci_process_bridge_OF_ranges() instances
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vitaly Bordug <vitb@kernel.crashing.org>
In-Reply-To: <20070911224952.9838.46644.stgit@localhost.localdomain>
References: <20070911224952.9838.46644.stgit@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 19 Sep 2007 07:42:28 +1000
Message-Id: <1190151748.6403.116.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Oh and...

PowerMac -needs- the coalescing of ranges. Apple tends to split their
ranges in bits in the device-tree and ends up with more than you have
struct resource in the pci_bus.

Ben.
