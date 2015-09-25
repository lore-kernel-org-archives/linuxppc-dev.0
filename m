Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0139.outbound.protection.outlook.com [157.56.111.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 837271A0145
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2015 03:09:20 +1000 (AEST)
Message-ID: <1443200946.32298.118.camel@freescale.com>
Subject: Re: [PATCH v2 08/25] powerpc/8xx: Map IMMR area with 512k page at a
 fixed address
From: Scott Wood <scottwood@freescale.com>
To: David Laight <David.Laight@ACULAB.COM>
CC: 'Christophe Leroy' <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Fri, 25 Sep 2015 12:09:06 -0500
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CBA2CBE@AcuExch.aculab.com>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <bfa8400abd8b5174942616aae5876a55242f5468.1442939410.git.christophe.leroy@c-s.fr>
 <063D6719AE5E284EB5DD2968C1650D6D1CBA15B8@AcuExch.aculab.com>
 <1443125663.32298.32.camel@freescale.com>
 <063D6719AE5E284EB5DD2968C1650D6D1CBA2CBE@AcuExch.aculab.com>
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

On Fri, 2015-09-25 at 14:46 +0000, David Laight wrote:
> From: Scott Wood
> > Sent: 24 September 2015 21:14
> > > Isn't this a more general problem?
> > > 
> > > If there are multiple remap requests for the same physical page
> > > shouldn't the kernel be just increasing a reference count somewhere
> > > and returning address in the same virtual page?
> > > This should probably happen regardless of the address.
> > > I presume it must be done for cacheable mappings.
> > 
> > Why would you assume that?
> 
> Because 'really horrid (tm)' things happen on some cache
> architectures if you map the same physical address to
> multiple virtual addresses.

PPC is not such an architecture.

-Scott
