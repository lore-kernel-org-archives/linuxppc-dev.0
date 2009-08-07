Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 71013B804D
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 12:27:18 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C6E44DDD01
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 12:27:17 +1000 (EST)
Message-Id: <3B4372B1-C670-47B7-914A-89A87CA8D7DF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: akpm@linux-foundation.org
In-Reply-To: <200908062300.n76N0bnS028871@imap1.linux-foundation.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [patch 2/3] powerpc/fsl-booke: read buffer overflow
Date: Thu, 6 Aug 2009 21:27:05 -0500
References: <200908062300.n76N0bnS028871@imap1.linux-foundation.org>
Cc: roel.kluin@gmail.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 6, 2009, at 6:00 PM, akpm@linux-foundation.org wrote:

> From: Roel Kluin <roel.kluin@gmail.com>
>
> cam[tlbcam_index] is checked before tlbcam_index < ARRAY_SIZE(cam)
>
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
> arch/powerpc/mm/fsl_booke_mmu.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)


applied to next

- k
