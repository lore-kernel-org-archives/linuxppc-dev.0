Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJqD62VtVzDqfp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 20:17:10 +1000 (AEST)
In-Reply-To: <1460010507-24777-1-git-send-email-ruscur@russell.cc>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [V3,
 1/2] pseries/eeh: Handle RTAS delay requests in configure_bridge
Message-Id: <3rJqD61jttz9t3s@ozlabs.org>
Date: Tue, 31 May 2016 20:17:10 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-07-04 at 06:28:26 UTC, Russell Currey wrote:
> In the "ibm,configure-pe" and "ibm,configure-bridge" RTAS calls, the
> spec states that values of 9900-9905 can be returned, indicating that
> software should delay for 10^x (where x is the last digit, i.e. 990x)
> milliseconds and attempt the call again. Currently, the kernel doesn't
> know about this, and respecting it fixes some PCI failures when the
> hypervisor is busy.
> 
> The delay is capped at 0.2 seconds.
> 
> Cc: <stable@vger.kernel.org> # 3.10+
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/871e178e0f2c4fa788f694721a

cheers
