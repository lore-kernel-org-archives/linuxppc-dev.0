Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rtKvV5dk3zDqLd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 21:00:06 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Kees Cook <keescook@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 oss@buserror.net <oss@buserror.net>
Subject: Re: linux-next: manual merge of the kspp tree with the powerpc tree
In-Reply-To: <20160718130315.314f8a77@canb.auug.org.au>
References: <20160718130315.314f8a77@canb.auug.org.au>
Date: Mon, 18 Jul 2016 21:00:05 +1000
Message-ID: <871t2rb496.fsf@@concordia.ellerman.id.au>
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

> Hi Kees,
>
> Today's linux-next merge of the kspp tree got a conflict in:
>
>   arch/powerpc/Kconfig
>
> between commit:
>
>   c223c90386bc ("powerpc32: provide VIRT_CPU_ACCOUNTING")
>
> from the powerpc tree and commit:

Actually that's in Scott's tree.

I didn't love it, but I guess it's OK to go in.

>   006d998dda94 ("powerpc/uaccess: Enable hardened usercopy")
>
> from the kspp tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> Michael: time to sort these selects?

Yeah I was thinking that the other day. Not sure when is a good time though.

cheers
