Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Qzg439F3zF35s
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 12:00:48 +1000 (AEST)
Message-ID: <f003a7aa17070a483aa66a80caa9c26f44639e9a.camel@neuling.org>
Subject: Re: [PATCH 1/3] selftests/powerpc: Remove Power9 copy_unaligned test
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: chris@distroguy.com
Date: Thu, 12 Jul 2018 12:00:47 +1000
In-Reply-To: <20180711071017.5128-1-mpe@ellerman.id.au>
References: <20180711071017.5128-1-mpe@ellerman.id.au>
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

On Wed, 2018-07-11 at 17:10 +1000, Michael Ellerman wrote:
> This is a test of the ISA 3.0 "copy" instruction. That instruction has
> an L field, which if set to 1 specifies that "the instruction
> identifies the beginning of a move group" (pp 858). That's also
> referred to as "copy first" vs "copy".
>=20
> In ISA 3.0B the copy instruction does not have an L field, and the
> corresponding bit in the instruction must be set to 1.
>=20
> This test is generating a "copy" instruction, not a "copy first", and
> so on Power9 (which implements 3.0B), this results in an illegal
> instruction.
>=20
> So just drop the test entirely. We still have copy_first_unaligned to
> test the "copy first" behaviour.
>=20
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Michael Neuling <mikey@neuling.org>
