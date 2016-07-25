Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryc1j2X4DzDqTp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 19:50:17 +1000 (AEST)
Message-ID: <1469440186.5978.35.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/3] powerpc/mm: Rename hpte_init_lpar() & put fallback
 in a header
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Stephen Rothwell
 <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
Date: Mon, 25 Jul 2016 19:49:46 +1000
In-Reply-To: <871t2i1dv5.fsf@concordia.ellerman.id.au>
References: <1469415471-2476-1-git-send-email-mpe@ellerman.id.au>
 <1469415471-2476-2-git-send-email-mpe@ellerman.id.au>
 <20160725141326.6a155483@canb.auug.org.au>
 <871t2i1dv5.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-07-25 at 15:33 +1000, Michael Ellerman wrote:
> When we detect a PS3 we set both PS3_LV1 and LPAR at the same time,
> so
> there should be no way they can get out of sync, other than due to a
> bug in the code.

I thought I had changed PS3 to no longer set LPAR ? I like having a
flag that basically says PAPR and that's pretty much what LPAR is,
in fact I think I've been using it elsewhere with that meaning

Cheers,
Ben.
