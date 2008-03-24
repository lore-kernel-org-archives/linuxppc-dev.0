Return-Path: <jblack547@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id AF0ABDDE32
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Mar 2008 08:59:54 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so640242anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Mar 2008 14:59:53 -0700 (PDT)
Message-ID: <b77025b40803241459s4537b1f6rdcf85c59a4af6707@mail.gmail.com>
Date: Mon, 24 Mar 2008 15:59:53 -0600
From: "James Black" <jblack547@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: muram in device tree for mpc8250 in arch/powerpc
In-Reply-To: <47E822EC.9030408@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <b77025b40803191006m60dc3145la368ac227df43b17@mail.gmail.com>
	<47E2AADD.6090101@freescale.com>
	<b77025b40803201602q68fce3e1j703502a270351179@mail.gmail.com>
	<20080321161833.GA4170@loki.buserror.net>
	<b77025b40803211314g74a41aa9of01f7cf3560a2505@mail.gmail.com>
	<47E41BE7.9020109@freescale.com>
	<b77025b40803211435g25e8cee7w75bfe4ed9c13796@mail.gmail.com>
	<47E7DC46.2010806@freescale.com>
	<b77025b40803241445w46aaf071k427df888b4597c4d@mail.gmail.com>
	<47E822EC.9030408@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

OK, you are right. I was looking at my old copy I was trying to fix.
The error is,

arch/powerpc/boot/cuboot-pq2.c: In function 'fixup_pci':
arch/powerpc/boot/cuboot-pq2.c:204: warning: implicit declaration of
function '__ilog2_u32'


On Mon, Mar 24, 2008 at 3:53 PM, Scott Wood <scottwood@freescale.com> wrote:
> James Black wrote:
>  > I started from scratch and am trying to build the cuImage. I get this
>  > compiler error.
>  >
>  > arch/powerpc/boot/cuboot-pq2.c:14:20: error: bitops.h: No such file or directory
>  > arch/powerpc/boot/cuboot-pq2.c: In function 'fixup_pci':
>  > arch/powerpc/boot/cuboot-pq2.c:205: warning: implicit declaration of
>  > function '__ilog2_u32'
>  >
>  > I looks as though cuboot-pq2.c expects bitops.h to be in the same
>  > directory, but it has moved to
>  > linux/include/asm-powerpc/bitops.h
>
>  I don't see any reference to bitops.h in cuboot-pq2.c...
>  Line 14 includes "ops.h".
>
>  -Scott
>
>
