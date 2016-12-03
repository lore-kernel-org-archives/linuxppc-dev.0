Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tW80M738DzDw30
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2016 22:28:19 +1100 (AEDT)
In-Reply-To: <d7b1e63e-7b9f-1f0e-df57-5f2e08e0ca6e@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [v2] Fix the message in facility unavailable exception
Message-Id: <3tW80M4sb7z9t1P@ozlabs.org>
Date: Sat,  3 Dec 2016 22:28:19 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-11-30 at 06:45:09 UTC, Balbir Singh wrote:
> I ran into this during some testing on qemu. The current
> facility_strings[] are correct when the trap address is
> 0xf80 (hypervisor facility unavailable). When the trap
> address is 0xf60, IC (Interruption Cause) a.k.a status
> in the code is undefined for values 0 and 1. This patch
> adds a check to prevent printing the wrong information
> and helps better direct debugging effort.
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/93c2ec0f7019a155769d1ecfc08a7d

cheers
