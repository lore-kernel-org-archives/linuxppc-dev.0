Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcVl85V8LzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 20:51:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>,
 Balbir Singh <bsingharora@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/7] powerpc/mm: rename map_page() to map_kernel_page() on
 PPC32
In-Reply-To: <83aadb3163da87ec017ca4a61afcc29520a27eff.1496070452.git.christophe.leroy@c-s.fr>
References: <cover.1496070452.git.christophe.leroy@c-s.fr>
 <83aadb3163da87ec017ca4a61afcc29520a27eff.1496070452.git.christophe.leroy@c-s.fr>
Date: Tue, 30 May 2017 20:50:59 +1000
Message-ID: <8760gi62jw.fsf@concordia.ellerman.id.au>
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

Christophe Leroy <christophe.leroy@c-s.fr> writes:

...

Please tell me why.

You also moved the declaration from mmu_decl.h to book3s/32/pgtable.h,
but didn't update any includes, presumably we're confident everything
gets pgtable.h somehow?

cheers
