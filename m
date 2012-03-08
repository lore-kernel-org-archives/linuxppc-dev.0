Return-Path: <B34182@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 17753B6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2012 17:33:21 +1100 (EST)
Subject: RE: [PATCH v2] powerpc/srio: Fix the compile errors when building
 with 64bit
From: Liu Gang <Gang.Liu@freescale.com>
To: David Laight <David.Laight@ACULAB.COM>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B6E91@saturn3.aculab.com>
References: <AE90C24D6B3A694183C094C60CF0A2F6026B6E91@saturn3.aculab.com>
Content-Type: text/plain
Date: Thu, 8 Mar 2012 14:31:17 +0800
Message-ID: <1331188278.23420.157.camel@10.ap.freescale.net>
MIME-Version: 1.0
Cc: r58472@freescale.com, paul.gortmaker@windriver.com, r61911@freescale.com,
 linux-kernel@vger.kernel.org, Alexandre.Bounine@idt.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, David,

On Wed, 2012-03-07 at 13:18 +0000, David Laight wrote:  
> >  	pr_debug("RIO: fsl_add_outb_message(): destid %4.4x mbox %d
> buffer " \
> > -		 "%8.8x len %8.8x\n", rdev->destid, mbox, (int)buffer,
> len);
> > +		 "%8.8lx len %8.8zx\n", rdev->destid, mbox,
> > +		(unsigned long)buffer, len);
> 
> Should 'buffer' be printed with %p ??

Yes, printing with "%p" can get rid of the cast, although they have the
same print results.

Thanks a lot.

Liu Gang
