Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9A7FADDE29
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 00:20:02 +1000 (EST)
Date: Wed, 19 Sep 2007 09:19:53 -0500
From: Scott Wood <scottwood@freescale.com>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Subject: Re: cuImage generation
Message-ID: <20070919141953.GB8023@ld0162-tx32.am.freescale.net>
References: <20070919072831.322800@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070919072831.322800@gmx.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 19, 2007 at 09:28:31AM +0200, Gerhard Pircher wrote:
> I tried to compile a 2.6.23-rc6 kernel yesterday, but wasn't able to get a
> cuImage.<platform) out of it (only the uImage file was generated). My
> platform config defines DEFAULT_UIMAGE and WANT_DEVICE_TREE. Do I need to
> generate it manually or is there a makefile where I have to specify it?
> Naturally I added my cuboot wrapper code to the arch/powerpc/boot/Makefile.

Did you specify a device tree to use in CONFIG_DEVICE_TREE?

-Scott
