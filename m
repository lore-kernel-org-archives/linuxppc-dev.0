Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7bDM1KMFzDqk6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 22:46:43 +1000 (AEST)
In-Reply-To: <1499770669-9255-1-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/perf: Fix SDAR_MODE value for continous sampling in power9
Message-Id: <3x7bDL64p0z9s82@ozlabs.org>
Date: Thu, 13 Jul 2017 22:46:42 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-07-11 at 10:57:49 UTC, Madhavan Srinivasan wrote:
> Incase of continous sampling, code currently defaults
> MMCRA[SDAR_MODE] to 0b01 for power9 DD1 which is
> 'Continous sampling mode update SDAR on TLB miss'.
> And for the rest it copies the sdar_mode value from
> the event code, which mostly turns out to be 0b00
> ('No Updates').
> 
> Instead, fix the sdar_mode to 0b10
> ('Continous sampling mode update SDAR on dcache miss')
> as default for power9 incase of continous sampling.
> 
> Fixes: 78b4416aa2493 ('powerpc/perf: Handle sdar_mode for marked event in power9')
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/20dd4c624d25156d5ec3345bbb690b

cheers
