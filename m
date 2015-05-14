Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0131.outbound.protection.outlook.com [65.55.169.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 636871A04B3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 10:49:40 +1000 (AEST)
Message-ID: <1431564565.3868.157.camel@freescale.com>
Subject: Re: [PATCH 1/4] Partially revert "powerpc: Remove duplicate
 cacheable_memcpy/memzero functions"
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Wed, 13 May 2015 19:49:25 -0500
In-Reply-To: <b87a9787efc35a8bd6cd7f73185e9959b84ff84a.1431436210.git.christophe.leroy@c-s.fr>
References: <cover.1431436210.git.christophe.leroy@c-s.fr>
 <b87a9787efc35a8bd6cd7f73185e9959b84ff84a.1431436210.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Kyle Moffett <Kyle.D.Moffett@boeing.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-05-12 at 15:32 +0200, Christophe Leroy wrote:
> This partially reverts
> commit 'powerpc: Remove duplicate cacheable_memcpy/memzero functions
> ("f909a35bdfb7cb350d078a2cf888162eeb20381c")'

I don't have that SHA.  Do you mean
b05ae4ee602b7dc90771408ccf0972e1b3801a35?

> Functions cacheable_memcpy/memzero are more efficient than
> memcpy/memset as they use the dcbz instruction which avoids refill
> of the cacheline with the data that we will overwrite.

I don't see anything in this patchset that addresses the "NOTE: The old
routines are just flat buggy on kernels that support hardware with
different cacheline sizes" comment.

-Scott
