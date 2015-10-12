Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A78591A0AB3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 22:21:24 +1100 (AEDT)
In-Reply-To: <1437544469-20028-1-git-send-email-sam.mj@au1.ibm.com>
To: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
Subject: Re: [RFC] powerpc/kexec: Wait 1s for secondaries to enter OPAL
Message-Id: <20151012112124.84A8F1402B9@ozlabs.org>
Date: Mon, 12 Oct 2015 22:21:24 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-22-07 at 05:54:29 UTC, Samuel Mendoza-Jonas wrote:
> Always include a timeout when waiting for secondary cpus to enter OPAL
> in the kexec path, rather than only when crashing.
> 
> Signed-off-by: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1b70386c99e997b359735c75

cheers
