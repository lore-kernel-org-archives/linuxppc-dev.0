Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2F42868135
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 18:45:41 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix cell "new style" mapping and add debug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <1163131880.4982.107.camel@localhost.localdomain>
References: <1163131880.4982.107.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 10 Nov 2006 18:45:27 +1100
Message-Id: <1163144727.4982.146.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-11-10 at 15:11 +1100, Benjamin Herrenschmidt wrote:
> This patch fixes a typo in the "new style" code for mapping SPE
> resources, which causes it to try to map 4 times the same resource.
> 
> It also adds some pr_debug's that are useful to track down issues with
> the firmware when bringinh up new machines.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> --

Note that this patch is included in the serie I'm just posting.

Ben.
