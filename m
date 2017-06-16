Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpwZ34Vq9zDq88
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 19:49:15 +1000 (AEST)
In-Reply-To: <20170614030125.45899-1-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [kernel] powerpc/debug: Add missing warn flag to WARN_ON's
 non-builtin path
Message-Id: <3wpwZ33lkXz9sCX@ozlabs.org>
Date: Fri, 16 Jun 2017 19:49:14 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-06-14 at 03:01:25 UTC, Alexey Kardashevskiy wrote:
> When trapped on WARN_ON(), report_bug() is expected to return
> BUG_TRAP_TYPE_WARN so the caller could increment NIP by 4 and continue.
> The __builtin_constant_p() path of the PPC's WARN_ON() calls (indirectly)
> __WARN_FLAGS() which has BUGFLAG_WARNING set, however the other branch
> does not which makes report_bug() report a bug rather than a warning.
> 
> Fixes: f26dee15103f ("debug: Avoid setting BUGFLAG_WARNING twice")
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/a093c92dc7f96a15de98ec8cfe38e6

cheers
