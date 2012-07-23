Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6799C2C028D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 17:27:21 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Update g5_defconfig
References: <1343011712.2957.5.camel__22210.4697292254$1343011753$gmane$org@pasglop>
 <m2fw8jyn43.fsf@igel.home> <1343027168.2957.30.camel@pasglop>
Date: Mon, 23 Jul 2012 09:27:15 +0200
In-Reply-To: <1343027168.2957.30.camel@pasglop> (Benjamin Herrenschmidt's
 message of "Mon, 23 Jul 2012 17:06:08 +1000")
Message-ID: <m2boj7ym24.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> What do you mean by "lots of problems" ?

For example, only half of the screen is drawn.  There is a bug open
about this, but no comments.

> Also can you remind me what machine model and what video card variant ?

PowerMac7,3 with NV34 [GeForce FX 5200 Ultra] (rev a1).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
