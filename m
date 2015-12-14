Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0144.outbound.protection.outlook.com [157.56.110.144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B923F1A0026
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 09:20:31 +1100 (AEDT)
Message-ID: <1450131605.15946.396.camel@freescale.com>
Subject: Re: [POWERPC] bootwrapper: One check less in fsl_get_immr() after
 error detection
From: Scott Wood <scottwood@freescale.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 <linuxppc-dev@lists.ozlabs.org>
CC: LKML <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
 Julia Lawall <julia.lawall@lip6.fr>
Date: Mon, 14 Dec 2015 16:20:05 -0600
In-Reply-To: <566F3E49.2010506@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <566F3E49.2010506@users.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-12-14 at 23:10 +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 14 Dec 2015 23:01:32 +0100
> 
> A status check was performed by the fsl_get_immr() function even if it
> was known already that a system setting did not fit to the expectations.
> 
> This implementation detail could be improved by an adjustment for
> a jump label according to the Linux coding style convention.

What is the actual problem you're trying to solve?  Cluttering the code to
micro-optimize an error path is not an improvement.

-Scott
