Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ECE731A0058
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 23:32:15 +1100 (AEDT)
In-Reply-To: <1427261761-22952-7-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 06/27] powerpc: Create the pci_controller_ops struct.
Message-Id: <20150330123215.D44FB14016B@ozlabs.org>
Date: Mon, 30 Mar 2015 23:32:15 +1100 (AEDT)
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-25-03 at 05:35:40 UTC, Daniel Axtens wrote:
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  arch/powerpc/include/asm/pci-bridge.h | 7 +++++++
>  1 file changed, 7 insertions(+)

That's taking splitting patches to the next level :)

Just fold this into the next one where you first need it.

cheers
