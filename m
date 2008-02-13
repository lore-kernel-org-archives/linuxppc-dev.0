Return-Path: <dhbaird@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id 57E0BDE085
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Feb 2008 04:51:06 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so131744wag.13
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Feb 2008 09:51:06 -0800 (PST)
Message-ID: <440abda90802130951h7a23743asc85454bf089c7e55@mail.gmail.com>
Date: Wed, 13 Feb 2008 10:51:05 -0700
From: "David Baird" <dhbaird@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: TLB Miss booting linux kernel on ppc 405
In-Reply-To: <5ee408090802130938u7d069636g42a496e489fe5b80@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <5ee408090802130850w130ce09an507ca5c4d41cc5a8@mail.gmail.com>
	<440abda90802130917x79c3c990j6a1fc7c12ba05ed7@mail.gmail.com>
	<5ee408090802130938u7d069636g42a496e489fe5b80@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Feb 13, 2008 10:38 AM, Ricardo Ayres Severo <severo.ricardo@gmail.com> wrote:
> I tracked the kernel execution using step one instruction (si) on gdb
> and matching the jumps with the System.map.
> It is a Data TLB Miss and this is the register dump after the miss occurs:
>
>     r1: 00502090
>     r2: 0000000f
>     r3: c00003c0
>     r4: c0000000
>     r5: 00000000
>     r6: 00000000
>     r7: 74747955
>     r8: 4c302c39
>     r9: 00000000
>     pc: 00001100
>     lr: 00000018

Can you also past the special registers (srrd in XMD)?  I am very
curious about SRR0 and SRR1 and maybe some of the others.

> Now I'm checking the PPC cache configurations on XPS, because when
> treating the DTLB Miss Exception a Machine Check Exception occurs when
> it works with L1. Does this makes sense or am I confusing things?

Too soon for me to tell :-)
