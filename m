Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPxqy04RjzF0XZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 14:34:21 +1100 (AEDT)
In-Reply-To: <20171226132548.22177-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>, 
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/xmon: Do not compute/store the major opcode
Message-Id: <3zPxqx32Vlz9s9Y@ozlabs.org>
Date: Mon, 22 Jan 2018 14:34:21 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-12-26 at 13:25:47 UTC, Mathieu Malaterre wrote:
> In commit 5b102782c7f4 ("powerpc/xmon: Enable disassembly files (compilation
> changes)") usage of variable `op` has been removed. Completely remove opcode
> computation since not used anymore.
> 
> Fix fatal warning:
> 
> arch/powerpc/xmon/ppc-dis.c: In function ‘lookup_powerpc’:
> arch/powerpc/xmon/ppc-dis.c:96:17: error: variable ‘op’ set but not used [-Werror=unused-but-set-variable]
>    unsigned long op;
>                  ^~
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/104d55ae4df928c205268c1eb83b80

cheers
