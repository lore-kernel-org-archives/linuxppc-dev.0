Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0123.outbound.protection.outlook.com [207.46.100.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 22CED1A02EE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 10:52:28 +1100 (AEDT)
Date: Fri, 20 Mar 2015 18:52:13 -0500
From: Scott Wood <scottwood@freescale.com>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Subject: Re: powerpc32: fix warning from include/linux/mm.h
Message-ID: <20150320235213.GA1233@home.buserror.net>
References: <20141205112020.640FA1A5D4F@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20141205112020.640FA1A5D4F@localhost.localdomain>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 05, 2014 at 12:20:20PM +0100, LEROY Christophe wrote:
> include/linux/mm.h: In function 'is_vmalloc_addr':
> include/linux/mm.h:367:14: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
>   return addr >= VMALLOC_START && addr < VMALLOC_END;
>               ^
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/pgtable-ppc32.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

That warning doesn't appear to be enabled.  What config are you seeing
this with?

I'm also not clear on why this was assigned to me in patchwork.

-Scott
