Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4CYk6cLbzDqBn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 07:48:42 +1000 (AEST)
In-Reply-To: <1462337190-13230-1-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>, mikey <mikey@neuling.org>,
 <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: cxl: Handle num_of_processes larger than can fit in the SPA
Message-Id: <3r4CYk4jRrz9t45@ozlabs.org>
Date: Wed, 11 May 2016 07:48:42 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-04-05 at 04:46:30 UTC, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> num_of_process is a 16 bit field, theoretically allowing an AFU to
> support 16K processes, however the scheduled process area currently has
> a maximum size of 1MB, which limits the maximum number of processes to
> 7704.
> 
> Some AFUs may not necessarily care what the limit is and just want to be
> able to use the maximum by setting the field to 16K. To allow these to
> work, detect this situation and use the maximum size for the SPA.
> 
> Downgrade the WARN_ON to a dev_warn.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/eb8724b8dc99462a8fd1fa5734

cheers
