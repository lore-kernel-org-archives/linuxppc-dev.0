Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D3F1CDE007
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 02:12:27 +1000 (EST)
In-Reply-To: <461E51EA.90600@freescale.com>
References: <20070326205145.GA2868@ld0162-tx32.am.freescale.net>	<20070326205226.GB2931@ld0162-tx32.am.freescale.net>
	<17949.47307.827348.233684@cargo.ozlabs.ibm.com>
	<461E51EA.90600@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5925EF50-5323-4CF3-A145-251068AD9AA0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/5] bootwrapper: Add CONFIG_DEVICE_TREE
Date: Thu, 12 Apr 2007 11:11:24 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 12, 2007, at 10:36 AM, Scott Wood wrote:

> Paul Mackerras wrote:
>> Hmmm, I'm not sure that I want to be asked about  
>> CONFIG_DEVICE_TREE on
>> *all* powerpc platforms...  Surely this option should depend on
>> something that says we're including support for a uBoot-able  
>> platform?
>
> That's how I originally had it, but I was asked to make it more  
> general.
>   One non-uboot usage is Mark Greer's "Add Makefile rule to wrap dts
> file in zImage" patch.
>
> What about a CONFIG_WANT_DEVICE_TREE that platforms can select if they
> want to ask the user for a device tree?

Wouldn't we want this for all systems that don't have true OF?

- k
