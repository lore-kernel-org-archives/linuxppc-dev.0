Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ql3Pm5Cr2zDq5v
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 09:42:20 +1000 (AEST)
In-Reply-To: <1460401065-10540-2-git-send-email-jack@codezen.org>
To: Jack Miller <jack@codezen.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: michael.neuling@au1.ibm.com
Subject: Re: [1/3] powerpc: Complete FSCR context switch
Message-Id: <3ql3Pm4TZ5z9t4B@ozlabs.org>
Date: Wed, 13 Apr 2016 09:42:20 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-11-04 at 18:57:43 UTC, Jack Miller wrote:
> Previously we just saved the FSCR, but only restored it in some
> settings, and never copied it thread to thread. This patch always
> restores the FSCR and formalizes new threads inheriting its setting so
> that later we can manipulate FSCR bits in start_thread.

This seems like it's a bug in the current code?

cheers
