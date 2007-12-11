Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 34FAADDEC3
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 11:30:12 +1100 (EST)
Subject: Re: [PATCH] powerpc: Update smu command definitions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <20071211001849.38E70DDECF@ozlabs.org>
References: <20071211001849.38E70DDECF@ozlabs.org>
Content-Type: text/plain
Date: Tue, 11 Dec 2007 11:30:00 +1100
Message-Id: <1197333000.9071.21.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-12-11 at 11:18 +1100, Benjamin Herrenschmidt wrote:
> From: Michael Hanselmann <linux-kernel@hansmi.ch>
> 
> This patch updates smu.h with several new commands and parameter
> descriptions for existing ones.
> 
> Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> ---

Note that this patch has been around for a looooong time. For some
reason, it fell through the cracks but since it's really only
documentation (well, adding #defines for new commands and additional
comments, there is no actual code change), I think it's safe to go
in .24.

Cheers,
Ben.
