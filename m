Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 52C03DDF6B
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 01:36:17 +1000 (EST)
Message-ID: <461E51EA.90600@freescale.com>
Date: Thu, 12 Apr 2007 10:36:10 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/5] bootwrapper: Add CONFIG_DEVICE_TREE
References: <20070326205145.GA2868@ld0162-tx32.am.freescale.net>	<20070326205226.GB2931@ld0162-tx32.am.freescale.net>
	<17949.47307.827348.233684@cargo.ozlabs.ibm.com>
In-Reply-To: <17949.47307.827348.233684@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Hmmm, I'm not sure that I want to be asked about CONFIG_DEVICE_TREE on
> *all* powerpc platforms...  Surely this option should depend on
> something that says we're including support for a uBoot-able platform?

That's how I originally had it, but I was asked to make it more general. 
  One non-uboot usage is Mark Greer's "Add Makefile rule to wrap dts 
file in zImage" patch.

What about a CONFIG_WANT_DEVICE_TREE that platforms can select if they 
want to ask the user for a device tree?

-Scott
