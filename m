Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C8BC5B6FA8
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2012 21:42:03 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 00/15] PowerMac i2c API conversions & windfarm updates
References: <1334823416-9138-1-git-send-email-benh__1987.51832726902$1334826600$gmane$org@kernel.crashing.org>
 <m2397sz1er.fsf@igel.home> <1335343125.21961.33.camel@pasglop>
 <m2sjfs85pv.fsf@igel.home> <1335388465.21961.35.camel@pasglop>
 <m2aa1zxyt7.fsf@igel.home> <1335391128.21961.55.camel@pasglop>
 <m2liliam9w.fsf@igel.home> <1335431975.21961.75.camel@pasglop>
Date: Thu, 26 Apr 2012 13:41:58 +0200
In-Reply-To: <1335431975.21961.75.camel@pasglop> (Benjamin Herrenschmidt's
 message of "Thu, 26 Apr 2012 19:19:35 +1000")
Message-ID: <m2ehra67p5.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: khali@linux-fr.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> In fact, can you change that define around and see if it makes it behave
> more like therm_pm72 overall ? IE That's the only -known- difference
> between the old and new driver (+/- a bug / typo / etc..)

Yes, that's make the difference for the cpu fan control.  Note that
MacOS (at least 10.3, which is the only one I have) drives the fans the
same way as the old driver.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
