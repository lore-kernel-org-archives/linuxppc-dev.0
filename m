Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rmGtB1h2zzDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jul 2016 00:22:58 +1000 (AEST)
In-Reply-To: <1467695274-14667-41-git-send-email-benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [41/41] powerpc: Fix build with CONFIG_MEMORY_HOTPLUG on some
 configs
Message-Id: <3rmGt973Vwz9t0Z@ozlabs.org>
Date: Sat,  9 Jul 2016 00:22:57 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-05-07 at 05:07:54 UTC, Benjamin Herrenschmidt wrote:
> For memory hotplug to work, the MMU code needs to provide the functions
> create_section_mapping() and remove_section_mapping() to respectively
> map and unmap portions of the linear mapping.
> 
> At the moment only hash64 provides these, so we provide weak stubs that
> just error out. This fixes the build with configurations such as 64-bit
> BookE with CONFIG_MEMORY_HOTPLUG enabled.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fecbfabe1dc940525f26eb1683

cheers
