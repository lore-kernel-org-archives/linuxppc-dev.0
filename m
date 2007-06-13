Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CA754DDE49
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 03:36:20 +1000 (EST)
Message-ID: <46702B0C.9020604@am.sony.com>
Date: Wed, 13 Jun 2007 10:36:12 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 29/30] PS3: Device tree source.
References: <20070612181825.730300780@am.sony.com>>
	<466EEC01.6080807@am.sony.com>
	<f7c4ca74d3e2031e01264f31f09e515a@kernel.crashing.org>
	<20070613084023.GA28629@aepfle.de>
	<0502b4de346bce374f98c49a99be50c1@kernel.crashing.org>
	<20070613112448.GA29239@aepfle.de>
	<184b5119eca8beae9a28453096b6fe26@kernel.crashing.org>
In-Reply-To: <184b5119eca8beae9a28453096b6fe26@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>>> Please read up on what those properties mean exactly.
>>
>> Yes, do that before the inital release.
>>
>> currently name contains ''
>> currently compatible contains 'PS3PF'
>> currently model contains 'PLAYSTATION 3'
>>
>> Now, do not break the userspace ABI.
> 
> The device tree is not a userspace ABI.  Since
> in this case it is built into the kernel image
> (is it, actually?) there is no breakage between
> firmware and kernel versions, either.
> 
>> If there is really an urge to break it,
> 
> Break what?  It's just a bugfix.

This is the first time I am submitting the PS3 device tree
for inclusion in the mainline kernel, so there is no breakage
or even bugfix, just new code.

I understand that Olaf would like to match what the out-of-tree
2.6.16 legacy kernel port did, but that port was never accepted
nor even recognized by the Linux community.  I do not plan to
keep compatibility with that work in the mainline linux kernel.
Correctness will always take precedence over compatibility
in the mainline kernel. I will maintain what patches I can to
ease the transition from the legacy kernel to the mainline
kernel in the 'ps3-hacks' directory of my ps3-linux-patches.git
repository.  I will not submit those patches for mainline
inclusion though. I'm sorry for any inconvenience.

-Geoff
