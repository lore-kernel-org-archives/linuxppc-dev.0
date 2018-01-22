Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPxqm0BFKzF0X6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 14:34:12 +1100 (AEDT)
In-Reply-To: <8703033cf68861aba6424b8c13694e9823f50f98.1511506950.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [1/2] powerpc/lib/code-patching: refactor patch_instruction()
Message-Id: <3zPxql2q54z9sNx@ozlabs.org>
Date: Mon, 22 Jan 2018 14:34:11 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-11-24 at 07:31:07 UTC, Christophe Leroy wrote:
> patch_instruction() uses almost the same sequence as
> __patch_instruction()
> 
> This patch refactor it so that patch_instruction() uses
> __patch_instruction() instead of duplicating code.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8cf4c05712f04a405f0dacebcca8f0

cheers
