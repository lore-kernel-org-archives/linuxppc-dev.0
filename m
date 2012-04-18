Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:70:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9DCE5B6ED0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2012 00:56:00 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>
Subject: Re: PowerPC radeon KMS - is it possible?
References: <BAY163-W54EBB2437ED2068EF5AF5D03F0@phx.gbl>
 <1334730915.5989.265.camel__41553.0639271767$1334731329$gmane$org@thor.local>
 <m2liltbhkp.fsf@igel.home> <1334736133.5989.278.camel@thor.local>
 <m24nshb7l9.fsf@igel.home> <1334756287.5989.326.camel@thor.local>
 <m2bomp9krb.fsf@igel.home> <1334759498.5989.328.camel@thor.local>
Date: Wed, 18 Apr 2012 16:55:53 +0200
In-Reply-To: <1334759498.5989.328.camel@thor.local> ("Michel =?utf-8?Q?D?=
 =?utf-8?Q?=C3=A4nzer=22's?= message
 of "Wed, 18 Apr 2012 16:31:38 +0200")
Message-ID: <m27gxd9jie.fsf@igel.home>
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

> On Mit, 2012-04-18 at 16:28 +0200, Andreas Schwab wrote: 
>> Michel Dänzer <michel@daenzer.net> writes:
>> 
>> > Have you tried smaller aperture sizes (uninorth_agp.aperture) and/or
>> > radeon.test=1? (See commit 52f072cb084bbb460d3a4ae09f0b6efc3e7e8a8c)
>> 
>> Neither changes anything.
>
> How small aperture sizes have you tried?

32M. With the old UMS driver 3D once worked fine ...

> The purpose of radeon.test=1 isn't to change anything but to catch
> problems transferring data between system memory bound via AGP GART and
> video RAM. Does it pass for the whole AGP aperture?

AFAICT yes.  For the default 256M it printed "[drm] Tested GTT->VRAM and
VRAM->GTT copy for GTT offset" for every other offset from 0x201000
to 0xfe01000.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
