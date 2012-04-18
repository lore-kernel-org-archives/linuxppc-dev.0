Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:32:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8F5EEB6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2012 01:39:45 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>
Subject: Re: PowerPC radeon KMS - is it possible?
References: <BAY163-W54EBB2437ED2068EF5AF5D03F0@phx.gbl>
 <1334730915.5989.265.camel__41553.0639271767$1334731329$gmane$org@thor.local>
 <m2liltbhkp.fsf@igel.home> <1334736133.5989.278.camel@thor.local>
Date: Wed, 18 Apr 2012 17:39:39 +0200
In-Reply-To: <1334736133.5989.278.camel@thor.local> ("Michel =?utf-8?Q?D?=
 =?utf-8?Q?=C3=A4nzer=22's?= message
 of "Wed, 18 Apr 2012 10:02:13 +0200")
Message-ID: <m239819hhg.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: o jordan <ojordan12345@hotmail.co.uk>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

FWIW, I just got a GPU lockup also in PCI mode, but at least it isn't as
fatal (system still up apart from the unusable X display).

radeon 0000:00:10.0: GPU lockup CP stall for more than 10000msec
GPU lockup (waiting for 0x00000C3C last fence id 0x00000C34)
Failed to wait GUI idle while programming pipes. Bad things might happen.
radeon 0000:00:10.0: (r300_asic_reset:414) RBBM_STATUS=0x84110140
radeon 0000:00:10.0: (r300_asic_reset:433) RBBM_STATUS=0x80010140
radeon 0000:00:10.0: (r300_asic_reset:445) RBBM_STATUS=0x00000140
radeon 0000:00:10.0: GPU reset succeed
radeon 0000:00:10.0: GPU reset succeed
[drm] radeon: 1 quad pipes, 1 Z pipes initialized.
[drm] PCIE GART of 512M enabled (table at 0x0000000002C00000).
radeon 0000:00:10.0: WB enabled
[drm] fence driver on ring 0 use gpu addr 0x78000000 and cpu addr 0xefac7000
[drm] radeon: ring at 0x0000000078001000
[drm:r100_ring_test] *ERROR* radeon: ring test failed (scratch(0x15E4)=0xCAFEDEA
[drm:r100_cp_init] *ERROR* radeon: cp isn't working (-22).
radeon 0000:00:10.0: failed initializing CP (-22).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
