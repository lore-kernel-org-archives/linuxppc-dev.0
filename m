Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8g1d0s1jzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 11:40:37 +1100 (AEDT)
In-Reply-To: <bc39d538-80f2-e810-0d58-39522605e067@users.sourceforge.net>
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
 Nicholas Piggin <npiggin@gmail.com>, Oliver O'Halloran <oohall@gmail.com>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: powerpc/sstep: Return directly after a failed address_ok() in
 emulate_step()
Message-Id: <3v8g1c5k46z9tjx@ozlabs.org>
Date: Fri, 27 Jan 2017 11:40:36 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-01-21 at 14:45:19 UTC, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 21 Jan 2017 15:30:15 +0100
> 
> * Return directly after a call of the function "address_ok" failed
>   in a case block.
> 
>   This issue was detected by using the Coccinelle software.
> 
> * Delete two error code assignments which became unnecessary with
>   this refactoring.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3c4b66a6d0d2b9f2418f9a09d528e4

cheers
