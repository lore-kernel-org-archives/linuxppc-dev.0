Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:70:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1348AB6F6E
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2012 18:00:32 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 00/15] PowerMac i2c API conversions & windfarm updates
References: <1334823416-9138-1-git-send-email-benh__1987.51832726902$1334826600$gmane$org@kernel.crashing.org>
Date: Wed, 25 Apr 2012 10:00:28 +0200
In-Reply-To: <1334823416-9138-1-git-send-email-benh__1987.51832726902$1334826600$gmane$org@kernel.crashing.org>
 (Benjamin Herrenschmidt's message of "Thu, 19 Apr 2012 18:16:41
 +1000")
Message-ID: <m2397sz1er.fsf@igel.home>
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

> The biggest change is that windfarm is ported to generally use
> the new model, and I've written a new set of windfarm modules to
> take over from the old therm_pm72 (which was mostly unfixable)
> on the PowerMac G5 AGP and Xserve G5 machines.

I have the impression that the new driver keeps the fans running faster
all the time.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
