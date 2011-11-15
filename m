Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id E2163B7209
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2011 13:32:59 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [RFC PATCH 0/2] powerpc: CPU cache op cleanup
Date: Mon, 14 Nov 2011 21:32:09 -0500
Message-Id: <1321324332-22964-1-git-send-email-Kyle.D.Moffett@boeing.com>
In-Reply-To: <1320986410.21206.48.camel@pasglop>
References: <1320986410.21206.48.camel@pasglop>
Cc: B04825@freescale.com, linux-kernel@vger.kernel.org,
 paul.gortmaker@windriver.com, scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ok, so I have a work-in-progress patch for cleaning up the CPU cache
handling, and I'd like some comments on the approach.

It's not really split up, and it's kind of a huge patch because it
tries to tackle a lot of things at once.  Unfortunately, I'm having a
hard time finding good clean places to break things apart.

Furthermore, I know 100% that it is not complete on PPC32 yet, and it
almost certainly does not build on PPC64 yet either.

These are the only files in arch/powerpc/ which have known-incorrect
references to L1_CACHE_* variables:
  arch/powerpc/lib/copy_32.S
  arch/powerpc/kernel/misc_32.S

Unfortunately, I've been staring at PPC asm for long enough that I
have a migraine headache and I'm going to have to stop here for now.
If somebody else wants to tackle fixing up the 32-bit copy_page() and
__copy_tofrom_user() routines it would be highly appreciated.

Cheers,
Kyle Moffett

--
Curious about my work on the Debian powerpcspe port?
I'm keeping a blog here: http://pureperl.blogspot.com/
