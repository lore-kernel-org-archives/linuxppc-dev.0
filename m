Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D2FFD2C00B8
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jan 2014 21:03:21 +1100 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: add vr save/restore functions
References: <87eh4uif62.fsf@igel.home> <1389154699.2076.6.camel@concordia>
Date: Wed, 08 Jan 2014 10:54:10 +0100
In-Reply-To: <1389154699.2076.6.camel@concordia> (Michael Ellerman's message
 of "Wed, 08 Jan 2014 15:18:19 +1100")
Message-ID: <87fvoypznh.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <michael@ellerman.id.au> writes:

> On Mon, 2013-12-30 at 15:31 +0100, Andreas Schwab wrote:
>> GCC 4.8 now generates out-of-line vr save/restore functions when
>> optimizing for size.  They are needed for the raid6 altivec support.
>
> It looks like they're identical for 32 & 64-bit ?

They use different temporary registers and calling conventions (no .opd
for ppc64).
  
Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
