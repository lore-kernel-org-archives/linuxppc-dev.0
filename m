Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rySY25pBdzDqdf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 14:13:26 +1000 (AEST)
Date: Mon, 25 Jul 2016 14:13:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: <linuxppc-dev@ozlabs.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/3] powerpc/mm: Rename hpte_init_lpar() & put fallback
 in a header
Message-ID: <20160725141326.6a155483@canb.auug.org.au>
In-Reply-To: <1469415471-2476-2-git-send-email-mpe@ellerman.id.au>
References: <1469415471-2476-1-git-send-email-mpe@ellerman.id.au>
 <1469415471-2476-2-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Mon, 25 Jul 2016 12:57:50 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> hpte_init_lpar() is part of the pseries platform, so name it as such.
> Provide the fallback implementation in a header, rather than using a
> weak function.

firmware_has_feature(FW_FEATURE_LPAR) can also be true for
CONFIG_PPC_PS3.  Is this a problem?

-- 
Cheers,
Stephen Rothwell
