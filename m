Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:32:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7CC71B6FED
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 20:11:28 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 00/15] PowerMac i2c API conversions & windfarm updates
References: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
 <20120419113723.03a24d46__2279.25503063506$1334829915$gmane$org@endymion.delvare>
Date: Thu, 19 Apr 2012 12:11:25 +0200
In-Reply-To: <20120419113723.03a24d46__2279.25503063506$1334829915$gmane$org@endymion.delvare>
 (Jean Delvare's message of "Thu, 19 Apr 2012 11:37:23 +0200")
Message-ID: <m27gxc2fqq.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Christian Kujau <lists@nerdbynature.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jean Delvare <khali@linux-fr.org> writes:

> These drivers were the last ones blocking the removal of the legacy
> binding model in i2c-core.

There are also still some uses in snd-aoa.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
