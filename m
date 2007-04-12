Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3A8FEDDF52
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 02:17:28 +1000 (EST)
Message-ID: <461E5B91.5080101@freescale.com>
Date: Thu, 12 Apr 2007 11:17:21 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/5] bootwrapper: Add CONFIG_DEVICE_TREE
References: <20070326205145.GA2868@ld0162-tx32.am.freescale.net>	<20070326205226.GB2931@ld0162-tx32.am.freescale.net>
	<17949.47307.827348.233684@cargo.ozlabs.ibm.com>
	<461E51EA.90600@freescale.com>
	<5925EF50-5323-4CF3-A145-251068AD9AA0@kernel.crashing.org>
In-Reply-To: <5925EF50-5323-4CF3-A145-251068AD9AA0@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Apr 12, 2007, at 10:36 AM, Scott Wood wrote:
> 
>> Paul Mackerras wrote:
>>
>>> Hmmm, I'm not sure that I want to be asked about  CONFIG_DEVICE_TREE on
>>> *all* powerpc platforms...  Surely this option should depend on
>>> something that says we're including support for a uBoot-able  platform?
>>
>>
>> That's how I originally had it, but I was asked to make it more  general.
>>   One non-uboot usage is Mark Greer's "Add Makefile rule to wrap dts
>> file in zImage" patch.
>>
>> What about a CONFIG_WANT_DEVICE_TREE that platforms can select if they
>> want to ask the user for a device tree?
> 
> Wouldn't we want this for all systems that don't have true OF?

Not if there's a non-OF firmware that doesn't need to go through the 
bootwrapper (such as modern u-boot).

-Scott
