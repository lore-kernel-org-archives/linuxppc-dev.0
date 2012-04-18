Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7952DB6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2012 17:43:00 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>
Subject: Re: PowerPC radeon KMS - is it possible?
References: <BAY163-W54EBB2437ED2068EF5AF5D03F0@phx.gbl>
 <1334730915.5989.265.camel__41553.0639271767$1334731329$gmane$org@thor.local>
Date: Wed, 18 Apr 2012 09:42:52 +0200
In-Reply-To: <1334730915.5989.265.camel__41553.0639271767$1334731329$gmane$org@thor.local>
 ("Michel =?utf-8?Q?D=C3=A4nzer=22's?= message of "Wed, 18 Apr 2012 08:35:15
 +0200")
Message-ID: <m2ty0hbi4j.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: o jordan <ojordan12345@hotmail.co.uk>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michel Dänzer <michel@daenzer.net> writes:

> Not sure it's a good idea to set both of these =y: It will prevent the
> radeon driver from initializing at all by default if radeonfb is active.

You can say video=radeonfb:off.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
