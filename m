Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 9A975DE722
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 06:54:20 +1000 (EST)
Date: Thu, 14 Aug 2008 16:54:22 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 1/2] port ndfc driver to of platform
Message-ID: <20080814165422.62339a5f@lappy.seanm.ca>
In-Reply-To: <200808142216.45763.arnd@arndb.de>
References: <20080801233000.3574434f@lappy.seanm.ca>
	<200808141153.07983.arnd@arndb.de>
	<20080814120829.1ad4ed74@lappy.seanm.ca>
	<200808142216.45763.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 14 Aug 2008 22:16:45 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> If of_iomap and of_address_to_resource don't work properly, there
> is probably something wrong in your device tree, maybe an incorrect
> #size-cells or #address-cells or ranges property in one of
> the parents. You need to fix this anyway.

Gahhhh, no my dts is wrong. I must have looked at it a dozen times
before I clued in that now that ndfc is a proper of driver I need to
specify the chip select and the *offset*, not the chip select and the
*address*.

New patches soon.

Cheers,
   Sean
