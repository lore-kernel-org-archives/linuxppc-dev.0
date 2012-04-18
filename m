Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:70:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A4B05B6FBB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2012 17:54:49 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>
Subject: Re: PowerPC radeon KMS - is it possible?
References: <BAY163-W54EBB2437ED2068EF5AF5D03F0@phx.gbl>
 <1334730915.5989.265.camel__41553.0639271767$1334731329$gmane$org@thor.local>
Date: Wed, 18 Apr 2012 09:54:46 +0200
In-Reply-To: <1334730915.5989.265.camel__41553.0639271767$1334731329$gmane$org@thor.local>
 ("Michel =?utf-8?Q?D=C3=A4nzer=22's?= message of "Wed, 18 Apr 2012 08:35:15
 +0200")
Message-ID: <m2liltbhkp.fsf@igel.home>
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

> Probably not (AGP is flaky in general, but in particular with older
> UniNorth bridges), but it might be interesting to see some kernel output
> from booting without agpmode=-1. If you can't get it via ssh, maybe you
> can via netconsole or so.

While logging into KDE:

radeon 0000:00:10.0: GPU lockup CP stall for more than 10064msec
GPU lockup (waiting for 0x000003EE last fence id 0x000003ED)
radeon: wait for empty RBBM fifo failed ! Bad things might happen.
Failed to wait GUI idle while programming pipes. Bad things might happen.
radeon 0000:00:10.0: (r300_asic_reset:414) RBBM_STATUS=0x8802C137
radeon 0000:00:10.0: (r300_asic_reset:433) RBBM_STATUS=0x8802C137
radeon 0000:00:10.0: (r300_asic_reset:445) RBBM_STATUS=0x8802C137
radeon 0000:00:10.0: GPU reset succeed
radeon 0000:00:10.0: GPU reset succeed
radeon 0000:00:10.0: (r300_asic_reset:414) RBBM_STATUS=0x8802C137
radeon 0000:00:10.0: (r300_asic_reset:433) RBBM_STATUS=0x8802C137
radeon 0000:00:10.0: (r300_asic_reset:445) RBBM_STATUS=0x8802C137
radeon 0000:00:10.0: GPU reset succeed
radeon: wait for empty RBBM fifo failed ! Bad things might happen.
Failed to wait GUI idle while programming pipes. Bad things might happen.

After that is is dead.  GPU lockup appears to be a common problem with
the radeon driver.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
