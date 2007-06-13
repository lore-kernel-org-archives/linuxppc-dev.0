Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound6-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EE576DDE46
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 03:36:09 +1000 (EST)
Message-ID: <46702AFE.8080800@am.sony.com>
Date: Wed, 13 Jun 2007 10:35:58 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [patch 29/30] PS3: Device tree source.
References: <20070612181825.730300780@am.sony.com>>
	<466EEC01.6080807@am.sony.com>
	<f7c4ca74d3e2031e01264f31f09e515a@kernel.crashing.org>
	<20070613084023.GA28629@aepfle.de>
In-Reply-To: <20070613084023.GA28629@aepfle.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering wrote:
> On Wed, Jun 13, Segher Boessenkool wrote:
> 
>> There is one real bug though.
> 
> Indeed.
> 
>> > +/ {
>> > +	model = "PS3 Game Console";
>> 
>> model = "sony,some-model-number" or similar
>> 
>> > +	compatible = "PS3";
>> 
>> name = "sony,ps3"
> 
> Both are wrong.
> 
> Stick to the values used right now.
> Which is 'PS3PF'

Hi Olaf.

I specifically changed this because this kernel is
NOT compatible with the device tree of the legacy
kernel (2.6.16) that used PS3PF.

If this was set as PS3PF, then there would be no
way to tell that an incompatible DT has been passed.

See my patch below how I use it to work around the
incompatability:

http://git.kernel.org/?p=linux/kernel/git/geoff/ps3-linux-patches.git;a=blob;f=ps3-hacks/ps3-legacy-bootloader-hack.diff

-Geoff
