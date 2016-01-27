Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE8531A173B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 20:17:09 +1100 (AEDT)
Date: Wed, 27 Jan 2016 10:16:01 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christian Borntraeger <borntraeger@de.ibm.com>
cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 x86@kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, davej@codemonkey.org.uk
Subject: Re: [PATCH v2 2/3] x86: query dynamic DEBUG_PAGEALLOC setting
In-Reply-To: <1453884618-33852-3-git-send-email-borntraeger@de.ibm.com>
Message-ID: <alpine.DEB.2.11.1601271015380.3886@nanos>
References: <1453884618-33852-1-git-send-email-borntraeger@de.ibm.com>
 <1453884618-33852-3-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 27 Jan 2016, Christian Borntraeger wrote:

> We can use debug_pagealloc_enabled() to check if we can map
> the identity mapping with 2MB pages. We can also add the state
> into the dump_stack output.
> 
> The patch does not touch the code for the 1GB pages, which ignored
> CONFIG_DEBUG_PAGEALLOC. Do we need to fence this as well?
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
