Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 584FBB6FEB
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 20:20:01 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 00/15] PowerMac i2c API conversions & windfarm updates
References: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
 <20120419113723.03a24d46__2279.25503063506$1334829915$gmane$org@endymion.delvare>
 <m27gxc2fqq.fsf__16075.0973890119$1334830355$gmane$org@igel.home>
 <m239802flw.fsf__48316.0902433612$1334830569$gmane$org@igel.home>
Date: Thu, 19 Apr 2012 12:19:57 +0200
In-Reply-To: <m239802flw.fsf__48316.0902433612$1334830569$gmane$org@igel.home>
 (Andreas Schwab's message of "Thu, 19 Apr 2012 12:14:19 +0200")
Message-ID: <m2y5ps10s2.fsf@igel.home>
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

Andreas Schwab <schwab@linux-m68k.org> writes:

> Andreas Schwab <schwab@linux-m68k.org> writes:
>
>> Jean Delvare <khali@linux-fr.org> writes:
>>
>>> These drivers were the last ones blocking the removal of the legacy
>>> binding model in i2c-core.
>>
>> There are also still some uses in snd-aoa.
>
> Never mind, I just found the commit in tiwai/sound.git.

Confused.... this was some old one which has nothing to do with the
legacy binding model conversion.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
