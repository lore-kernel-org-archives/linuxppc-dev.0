Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJx0J0TzJzDqBm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2017 22:38:08 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alistair Popple <alistair@popple.id.au>
Subject: Re: linux-next: manual merge of the kvm-ppc tree with the powerpc tree
In-Reply-To: <20170209143701.4e37c1be@canb.auug.org.au>
References: <20170209143701.4e37c1be@canb.auug.org.au>
Date: Thu, 09 Feb 2017 22:38:06 +1100
Message-ID: <87shnn8uht.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi Paul,
>
> Today's linux-next merge of the kvm-ppc tree got conflicts in:
>
>   arch/powerpc/include/asm/opal.h
>   arch/powerpc/platforms/powernv/opal-wrappers.S
>
> between commit:
>
>   1d0761d2557d ("powerpc/powernv: Initialise nest mmu")
>
> from the powerpc tree and commit:
>
>   ab9bad0ead9a ("powerpc/powernv: Remove separate entry for OPAL real mode calls")
>
> from the kvm-ppc tree.

Thanks.

This will go away when I merge the ppc-kvm topic branch.

cheers
