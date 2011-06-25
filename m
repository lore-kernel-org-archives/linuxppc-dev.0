Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 07775B6FAD
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 25 Jun 2011 17:33:52 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Matt Evans <matt@ozlabs.org>
Subject: Re: [RFC PATCH 1/1] BPF JIT for PPC64
References: <4E04288F.4090201@ozlabs.org>
Date: Sat, 25 Jun 2011 09:33:46 +0200
In-Reply-To: <4E04288F.4090201@ozlabs.org> (Matt Evans's message of "Fri, 24
	Jun 2011 16:02:55 +1000")
Message-ID: <m2boxmxt45.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Matt Evans <matt@ozlabs.org> writes:

> +	stdu	r1, -128(r1);					\

> +	addi	r5, r1, 128+BPF_PPC_STACK_BASIC+(2*8);		\

> +	addi	r1, r1, 128;					\

> +					PPC_STD(r_M + i, 1, -128 + (8*i));

> +					PPC_LD(r_M + i, 1, -128 + (8*i));

s/128/BPF_PPC_STACK_SAVE/?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
