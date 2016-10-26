Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t3fLW0HC6zDt39
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 16:52:35 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Cyril Bur <cyrilbur@gmail.com>,
 Valentin Rothberg <valentinrothberg@gmail.com>
Cc: linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc: process.c: fix Kconfig typo
In-Reply-To: <1475708074.735.2.camel@gmail.com>
References: <20161005055726.5614-1-valentinrothberg@gmail.com>
 <1475708074.735.2.camel@gmail.com>
Date: Wed, 26 Oct 2016 16:52:34 +1100
Message-ID: <878ttby7vh.fsf@concordia.ellerman.id.au>
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

Cyril Bur <cyrilbur@gmail.com> writes:

> On Wed, 2016-10-05 at 07:57 +0200, Valentin Rothberg wrote:
>> s/ALIVEC/ALTIVEC/
>> 
>
> Oops, nice catch
>
>> Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
>
> Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

How did we not notice? Sounds like we need a new selftest.

Looks like this should have:

Fixes: dc16b553c949 ("powerpc: Always restore FPU/VEC/VSX if hardware transactional memory in use")


And I guess I need to start running checkkconfigsymbols.py on every
commit.

cheers
