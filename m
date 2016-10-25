Return-Path: <geoff@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t3Jvb66WbzDvjr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 03:46:35 +1100 (AEDT)
Subject: Re: [PATCH] powerpc: Use pr_warn instead of pr_warning
To: Joe Perches <joe@perches.com>, Anatolij Gustschin <agust@denx.de>,
 Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <af9bcd9cdbc64f2c2638ba869979de003ba4671c.1477367819.git.joe@perches.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Geoff Levand <geoff@infradead.org>
Message-ID: <e250fef5-d44d-700e-38f2-39eaa7f0267d@infradead.org>
Date: Tue, 25 Oct 2016 09:46:30 -0700
MIME-Version: 1.0
In-Reply-To: <af9bcd9cdbc64f2c2638ba869979de003ba4671c.1477367819.git.joe@perches.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/24/2016 09:00 PM, Joe Perches wrote:
> At some point, pr_warning will be removed so all logging messages use
> a consistent <prefix>_warn style.
> 
> Update arch/powerpc/

>  arch/powerpc/platforms/ps3/device-init.c        | 12 +++++-------
>  arch/powerpc/platforms/ps3/mm.c                 |  4 ++--
>  arch/powerpc/platforms/ps3/os-area.c            |  2 +-

PS3 parts look OK.

Acked-by: Geoff Levand <geoff@infradead.org>
