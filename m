Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C092BDDF57
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 11:32:45 +1100 (EST)
Subject: Re: [PATCH] powerpc: Add legacy PCI access via sysfs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <20081010025101.B48CADDEF7@ozlabs.org>
References: <20081010025101.B48CADDEF7@ozlabs.org>
Content-Type: text/plain
Date: Tue, 14 Oct 2008 11:32:38 +1100
Message-Id: <1223944358.8157.298.camel@pasglop>
Mime-Version: 1.0
Cc: linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-10-10 at 13:50 +1100, Benjamin Herrenschmidt wrote:
> This patch adds support for legacy_io and legacy_mem files in
> bus class directories in sysfs for powerpc
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> This is version 2, slightly different approach for getting at VGA
> memory which works a lot better with bridges providing a separate
> ISA Memory hole (which is the case of most of them).

Drop it Jesse. It's missing-quilt-ref busticated. One of these days
I'll figure a scripted way to avoid that problem.

New one on the way.

Cheers,
Ben.
