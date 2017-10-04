Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y6YFQ3R93zDqpx
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 22:14:18 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH 2/2] powerpc/strict_rwx: fixup region splitting
In-Reply-To: <20170927095111.10626-2-bsingharora@gmail.com>
References: <20170927095111.10626-1-bsingharora@gmail.com>
 <20170927095111.10626-2-bsingharora@gmail.com>
Date: Wed, 04 Oct 2017 22:14:17 +1100
Message-ID: <87o9pnp3li.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:

> We were aggressive with splitting regions and missed the case
> when _stext and __init_begin completely overlap addr and addr+mapping.
>
> This patch fixes that case and allows us to keep the largest possible
> mapping through the overlap. The patch also simplies the check
> into a function

Please do the fix in one patch, which we can backport if necessary, and
then move it into a function in a separate patch.

cheers
