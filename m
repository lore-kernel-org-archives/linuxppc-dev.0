Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42G3SX2ly6zF3Dq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 14:21:00 +1000 (AEST)
In-Reply-To: <20180905020951.10372-2-sjitindarsingh@gmail.com>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, joel@jms.id.au,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: Re: [1/2] powerpc/prom: Remove VLA in prom_check_platform_support()
Message-Id: <42G3SX12XHz9sCt@ozlabs.org>
Date: Thu, 20 Sep 2018 14:21:00 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-09-05 at 02:09:50 UTC, Suraj Jitindar Singh wrote:
> In prom_check_platform_support() we retrieve and parse the
> "ibm,arch-vec-5-platform-support" property of the chosen node.
> Currently we use a variable length array however to avoid this use an
> array of constant length 8.
> 
> This property is used to indicate the supported options of vector 5
> bytes 23-26 of the ibm,architecture.vec node. Each of these options
> is a pair of bytes, thus for 4 options we have a max length of 8 bytes.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ab91239942a900e209f72488627306

cheers
