Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHwhq4JKDzDqrw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 12:21:47 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 05/11] powerpc/topology: Remove the unused parent_node()
 macro
In-Reply-To: <1501076076-1974-6-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1501076076-1974-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <1501076076-1974-6-git-send-email-douly.fnst@cn.fujitsu.com>
Date: Thu, 27 Jul 2017 12:21:44 +1000
Message-ID: <87fudifwlj.fsf@concordia.ellerman.id.au>
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

Dou Liyang <douly.fnst@cn.fujitsu.com> writes:

> Commit a7be6e5a7f8d ("mm: drop useless local parameters of
> __register_one_node()") removes the last user of parent_node().
>
> The parent_node() macro in POWERPC platform is unnecessary.
>
> Remove it for cleanup.
>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/include/asm/topology.h | 2 --
>  1 file changed, 2 deletions(-)

Thanks for doing this series.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
