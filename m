Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7D0532C03A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 04:43:34 +1100 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Tom Musta <tommusta@gmail.com>
Subject: Re: [PATCH 1/3] powerpc: Enable emulate_step In Little Endian Mode
References: <1382125125.2206.22.camel@tmusta-sc.rchland.ibm.com>
 <1382125235.2206.24.camel@tmusta-sc.rchland.ibm.com>
Date: Wed, 30 Oct 2013 18:43:27 +0100
In-Reply-To: <1382125235.2206.24.camel@tmusta-sc.rchland.ibm.com> (Tom Musta's
 message of "Fri, 18 Oct 2013 14:40:35 -0500")
Message-ID: <878uxairi8.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: tmusta@gmail.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tom Musta <tommusta@gmail.com> writes:

> +#ifdef __LITTLE_ENDIAN__
> +	if (!regs->msr & MSR_LE)

That won't work.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
