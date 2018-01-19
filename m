Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zNJGY3DZSzF10S
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 22:18:13 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, "Linux Kernel
 Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the powerpc tree with the
 powerpc-fixes tree
In-Reply-To: <20180118092112.0e46a25c@canb.auug.org.au>
References: <20180118092112.0e46a25c@canb.auug.org.au>
Date: Fri, 19 Jan 2018 22:18:11 +1100
Message-ID: <87efmmayh8.fsf@concordia.ellerman.id.au>
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
>   arch/powerpc/kernel/setup-common.c
>
> between commit:
>
>   349524bc0da6 ("powerpc: Don't preempt_disable() in show_cpuinfo()")
>
> from the powerpc-fixes tree and commit:
>
>   f5f563012a70 ("powerpc: Make newline in cpuinfo unconditional")
>
> from the powerpc tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Nah that guy is a jerk.

Thanks for the report.

cheers
