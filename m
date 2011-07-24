Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id B28C0B6F6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 24 Jul 2011 18:06:08 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Michael =?utf-8?Q?B=C3=BCsch?= <m@bues.ch>
Subject: Re: Linux 3.0 boot failure on the Powerbook G4
References: <20110723222034.6757604b__32574.6897528463$1311473425$gmane$org@maggie>
Date: Sun, 24 Jul 2011 10:06:03 +0200
In-Reply-To: <20110723222034.6757604b__32574.6897528463$1311473425$gmane$org@maggie>
	("Michael =?utf-8?Q?B=C3=BCsch=22's?= message of "Sat,
	23 Jul 2011 22:20:34 +0200")
Message-ID: <m2tyacdrx0.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Büsch <m@bues.ch> writes:

> Linux 3.0 fails to boot _very_ early on my Powerbook G4. See the
> yaboot/OF screenshot:
> http://bues.ch/misc/linux-3.0-pbook.jpg
>
> Linux 2.6.39.2 boots fine.
> Does somebody have an idea?

Perhaps your image is getting too large?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
