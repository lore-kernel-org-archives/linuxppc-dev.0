Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DFD61B6F6E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2012 23:47:49 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>
Subject: Re: PowerPC radeon KMS - is it possible?
References: <BAY163-W54EBB2437ED2068EF5AF5D03F0@phx.gbl>
 <1334730915.5989.265.camel__41553.0639271767$1334731329$gmane$org@thor.local>
 <m2ty0hbi4j.fsf@igel.home> <1334735555.5989.272.camel@thor.local>
 <m28vhtb7tc.fsf@igel.home> <1334754160.5989.305.camel@thor.local>
 <m2k41d9nup.fsf@igel.home> <1334755511.5989.318.camel@thor.local>
Date: Wed, 18 Apr 2012 15:47:41 +0200
In-Reply-To: <1334755511.5989.318.camel@thor.local> ("Michel =?utf-8?Q?D?=
 =?utf-8?Q?=C3=A4nzer=22's?= message
 of "Wed, 18 Apr 2012 15:25:11 +0200")
Message-ID: <m2fwc19mo2.fsf@igel.home>
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

> On Mit, 2012-04-18 at 15:22 +0200, Andreas Schwab wrote: 
>> Michel Dänzer <michel@daenzer.net> writes:
>> 
>> > You do understand that 'prevent the radeon driver from initializing at
>> > all' means direct rendering won't work at all, even with older Mesa
>> > drivers?
>> 
>> Until radeondrmfb has suspend support, this is what I want.
>
> Then you could disable CONFIG_DRM_RADEON, or prevent the radeon module
> from loading. *shrug*

I have it built-in for easier testing.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
