Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0139.outbound.protection.outlook.com [207.46.100.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C63E61A0259
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 12:30:35 +1100 (AEDT)
Date: Tue, 24 Mar 2015 20:30:23 -0500
From: Scott Wood <scottwood@freescale.com>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Subject: Re: [v2,2/2] powerpc32: add support for csum_add()
Message-ID: <20150325013023.GA7588@home.buserror.net>
References: <20150203113927.8604D1A5F14@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20150203113927.8604D1A5F14@localhost.localdomain>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 03, 2015 at 12:39:27PM +0100, LEROY Christophe wrote:
> The C version of csum_add() as defined in include/net/checksum.h gives the
> following assembly:
>        0:       7c 04 1a 14     add     r0,r4,r3
>        4:       7c 64 00 10     subfc   r3,r4,r0
>        8:       7c 63 19 10     subfe   r3,r3,r3
>        c:       7c 63 00 50     subf    r3,r3,r0
> 
> include/net/checksum.h also offers the possibility to define an arch specific
> function.
> This patch provides a ppc32 specific csum_add() inline function.

What makes it 32-bit specific?

-Scott
