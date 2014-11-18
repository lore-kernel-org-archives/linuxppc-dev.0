Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB6D41A0808
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 15:33:14 +1100 (AEDT)
In-Reply-To: <1416192750.3375.7.camel@TP420>
To: Li Zhong <zhong@linux.vnet.ibm.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [powerpc] init nvram_pstore_info's buf_lock
Message-Id: <20141118043314.4517C14011D@ozlabs.org>
Date: Tue, 18 Nov 2014 15:33:14 +1100 (AEDT)
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-17-11 at 02:52:30 UTC, Li Zhong wrote:
> It seems nvram_pstore_info's buf_lock is not initialized before
> registering, which causes some strange behavior when trying to obtain
> the lock during kdump process.

What kind of strange behaviour? Does it still work and just print a warning?

It's static, so I'd expect it to be unlocked by default.

cheers
