Return-Path: <whitebox@nefkom.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EA7C6B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Jul 2009 07:20:04 +1000 (EST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 73296DDD0B
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Jul 2009 07:20:04 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: kernel mailz <kernelmailz@googlemail.com>
Subject: Re: Inline assembly queries [2]
References: <abe8a1fd0907022344k2eb9874ejdbda3209a7cadf40@mail.gmail.com>
	<20090703174031.GA12410@cynthia.pants.nu>
	<abe8a1fd0907031305r5cb9e2e8pec170bffb1c497ff@mail.gmail.com>
Date: Fri, 03 Jul 2009 23:19:57 +0200
In-Reply-To: <abe8a1fd0907031305r5cb9e2e8pec170bffb1c497ff@mail.gmail.com>
	(kernel mailz's message of "Sat, 4 Jul 2009 01:35:50 +0530")
Message-ID: <m2vdm9cvlu.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, gcc-help@gcc.gnu.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kernel mailz <kernelmailz@googlemail.com> writes:

> My query was more on %U1%X1, I guess it is specifying U and/or X for %1 right ?
> what does U/X stand for (is it similar to u - unsigned and x for a hex address)
> are there any more literals like U/X/...

The 'U' and 'X' modifiers expand to 'u' and 'x' resp, depending on the
form of the referenced memory operand.  That allows one to select the
right mnemonic among for example lwz, lwzu, lwzx and lwzux.  Those
modifiers must always be used together with the "m" constraint.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
