Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3DE27DDE25
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 07:44:26 +1000 (EST)
Subject: Re: [PATCH] [RFC][POWERPC] Merge 32 and 64
	bit	pci_process_bridge_OF_ranges() instances
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Valentine Barshak <vbarshak@ru.mvista.com>
In-Reply-To: <46EFBEA6.4050406@ru.mvista.com>
References: <20070911224952.9838.46644.stgit@localhost.localdomain>
	<46EFBEA6.4050406@ru.mvista.com>
Content-Type: text/plain
Date: Wed, 19 Sep 2007 07:44:19 +1000
Message-Id: <1190151861.6403.118.camel@localhost.localdomain>
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

On Tue, 2007-09-18 at 16:03 +0400, Valentine Barshak wrote:
> Do we need to ioremap on 64-bit? I think 64-bit uses different
> approach 
> in handling io space.

Yup, we changed that recently and I haven't yet modified ppc32 to catch
up (and may never do so, they have different constraints).

Ben.
