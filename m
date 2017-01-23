Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v6QJ51RYyzDqRL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 20:00:21 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 7/8] uapi: export all headers under uapi directories
In-Reply-To: <1484304406-10820-8-git-send-email-nicolas.dichtel@6wind.com>
References: <3131144.4Ej3KFWRbz@wuerfel>
 <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
 <1484304406-10820-8-git-send-email-nicolas.dichtel@6wind.com>
Date: Mon, 23 Jan 2017 20:00:19 +1100
Message-ID: <878tq2b17g.fsf@concordia.ellerman.id.au>
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

Nicolas Dichtel <nicolas.dichtel@6wind.com> writes:

> Regularly, when a new header is created in include/uapi/, the developer
> forgets to add it in the corresponding Kbuild file. This error is usually
> detected after the release is out.
>
> In fact, all headers under uapi directories should be exported, thus it's
> useless to have an exhaustive list.
>
> After this patch, the following files, which were not exported, are now
> exported (with make headers_install_all):
...
> asm-powerpc/perf_regs.h
...
>  arch/powerpc/include/uapi/asm/Kbuild        |  45 ---

Thanks for cleaning it up.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)


cheers
