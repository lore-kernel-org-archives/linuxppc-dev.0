Return-Path: <jblack547@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 11A7DDDE02
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Mar 2008 09:09:33 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so641013anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Mar 2008 15:09:32 -0700 (PDT)
Message-ID: <b77025b40803241509p44162ebfg2728bec85efb5d7a@mail.gmail.com>
Date: Mon, 24 Mar 2008 16:09:32 -0600
From: "James Black" <jblack547@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: muram in device tree for mpc8250 in arch/powerpc
In-Reply-To: <47E82591.9050907@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <b77025b40803191006m60dc3145la368ac227df43b17@mail.gmail.com>
	<20080321161833.GA4170@loki.buserror.net>
	<b77025b40803211314g74a41aa9of01f7cf3560a2505@mail.gmail.com>
	<47E41BE7.9020109@freescale.com>
	<b77025b40803211435g25e8cee7w75bfe4ed9c13796@mail.gmail.com>
	<47E7DC46.2010806@freescale.com>
	<b77025b40803241445w46aaf071k427df888b4597c4d@mail.gmail.com>
	<47E822EC.9030408@freescale.com>
	<b77025b40803241459s4537b1f6rdcf85c59a4af6707@mail.gmail.com>
	<47E82591.9050907@freescale.com>
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

I must have the old one. I don't see '__ilog2_u32' defined. This is
the kernel I got from denx eldk 4.2. I'll grab the kernel from
kernel.org and check there. Thanks.

JB

On Mon, Mar 24, 2008 at 4:05 PM, Scott Wood <scottwood@freescale.com> wrote:
> James Black wrote:
>  > OK, you are right. I was looking at my old copy I was trying to fix.
>  > The error is,
>  >
>  > arch/powerpc/boot/cuboot-pq2.c: In function 'fixup_pci':
>  > arch/powerpc/boot/cuboot-pq2.c:204: warning: implicit declaration of
>  > function '__ilog2_u32'
>
>  It's defined as an inline function in ops.h.  Do you have an old ops.h?
>
>  -Scott
>
