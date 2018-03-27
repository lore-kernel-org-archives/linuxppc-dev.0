Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409JXp2pPPzF27V
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 15:52:42 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, "Linux Kernel
 Mailing List" <linux-kernel@vger.kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>
Subject: Re: linux-next: manual merge of the powerpc tree with the
 powerpc-fixes tree
In-Reply-To: <20180327101125.145e4dc5@canb.auug.org.au>
References: <20180327101125.145e4dc5@canb.auug.org.au>
Date: Tue, 27 Mar 2018 15:52:41 +1100
Message-ID: <87lgeejf1i.fsf@concordia.ellerman.id.au>
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

> Hi all,
>
> Today's linux-next merge of the powerpc tree got a conflict in:
>
>   arch/powerpc/include/asm/cputable.h
>   arch/powerpc/kernel/dt_cpu_ftrs.c
>
> between commit:
>
>   a5d4b5891c2f ("powerpc/mm: Fixup tlbie vs store ordering issue on POWER9")
>
> from the powerpc-fixes tree and commits:
>
>   9bbf0b576d32 ("powerpc: Free up CPU feature bits on 64-bit machines")
>   b5af4f279323 ("powerpc: Add CPU feature bits for TM bug workarounds on POWER9 v2.2")
>
> from the powerpc tree.

Thanks, yeah that was a bit of disaster.

I'll merge fixes into next before sending to Linus.

cheers
