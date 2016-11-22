Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN60s4sDgzDvpV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:34:21 +1100 (AEDT)
In-Reply-To: <20161117161921.13232-1-tklauser@distanz.ch>
To: Tobias Klauser <tklauser@distanz.ch>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/mce: Remove unused but set variable
Message-Id: <3tN60s3Jkyz9t2T@ozlabs.org>
Date: Tue, 22 Nov 2016 11:34:21 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-11-17 at 16:19:21 UTC, Tobias Klauser wrote:
> Remove the unused but set variable srr1 in save_mce_event() to
> fix the following GCC warning when building with 'W=1':
> 
>   arch/powerpc/kernel/mce.c:75:11: warning: variable 'srr1' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d6d56ec738dcac4ac7716ccb7a08a4

cheers
