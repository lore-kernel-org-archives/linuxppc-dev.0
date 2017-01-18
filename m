Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v3Qll2T1GzDqLm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 23:10:27 +1100 (AEDT)
In-Reply-To: <1484710976-7711-1-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2] powerpc/perf: use MSR to report privilege level on P9 DD1
Message-Id: <3v3Qll0qGhz9tJD@ozlabs.org>
Date: Wed, 18 Jan 2017 23:10:27 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-01-18 at 03:42:56 UTC, Madhavan Srinivasan wrote:
> Since SIER and SIAR updates are not valid for some
> samples, patch forces the use of MSR and regs->nip instead
> for misc_flag updates. This is done by adding a new ppmu
> flag and updating user_siar value in perf_read_regs() accordingly.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/27593d72c4ad451ed13af35354b941

cheers
