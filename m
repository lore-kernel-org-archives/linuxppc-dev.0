Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E93AD2C0093
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2012 18:09:26 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Update g5_defconfig
References: <1343011712.2957.5.camel__22210.4697292254$1343011753$gmane$org@pasglop>
 <m2fw8jyn43.fsf@igel.home> <1343027168.2957.30.camel@pasglop>
 <m2boj7ym24.fsf@igel.home> <1343029161.2957.35.camel@pasglop>
Date: Tue, 31 Jul 2012 10:09:12 +0200
In-Reply-To: <1343029161.2957.35.camel@pasglop> (Benjamin Herrenschmidt's
 message of "Mon, 23 Jul 2012 17:39:21 +1000")
Message-ID: <m2sjc8cpxz.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Ben Skeggs <bskeggs@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It's even worse.  Since ec9b3a9de6b2a8a08c5250b466db92adf82b8d65
(drm/nouveau/i2c: resume use of i2c-algo-bit, rather than custom stack)
the system is just powered off in the middle of booting.  Since nothing
is calling pmu_request with PMU_SHUTDOWN it must be some kind of bit
banging that causes the PMU to freak out.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
