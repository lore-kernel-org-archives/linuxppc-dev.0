Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 18636B70E8
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Nov 2010 01:39:22 +1100 (EST)
Subject: Re: [PATCH] ppc44x:PHY fixup for USB on canyonlands board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20101110141914.GC26193@zod.rchland.ibm.com>
References: <201011101137.oAABbFoc015547@amcc.com>
	<20101110141914.GC26193@zod.rchland.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 11 Nov 2010 01:38:51 +1100
Message-ID: <1289399931.2147.1392.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Rupjyoti Sarmah <rsarmah@amcc.com>,
	rsarmah@apm.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-11-10 at 09:19 -0500, Josh Boyer wrote:
> With this being an arch_initcall, it will get called for every kind of
> platform in a multi-board kernel.  Another reason to only call it from
> a
> board specific probe function if it really is canyonlands specific. 

Right. Time to take canyonlands out of ppc4xx_simple and have its own
board file again. Do the fixups there.

Cheers,
Ben.
