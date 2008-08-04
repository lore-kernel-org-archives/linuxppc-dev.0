Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 2253EDDFDE
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Aug 2008 03:25:01 +1000 (EST)
Date: Mon, 4 Aug 2008 13:24:59 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH] port ndfc driver to arch/powerpc
Message-ID: <20080804132459.3fc12f59@lappy.seanm.ca>
In-Reply-To: <200808041825.02314.arnd@arndb.de>
References: <20080801233000.3574434f@lappy.seanm.ca>
	<200808041825.02314.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Sean MacLennan <sean.maclennan@ottawa.kanatek.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 4 Aug 2008 18:25:02 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> Shouldn't this instead use the device tree, like fsl_elbc, fsl_upm
> and pasemi_nand do?
> It feels awfully backwards to hardcode this stuff in the platform
> source code.

Yes, yes it should. This is just a patch to get the driver working... it
is not a full blown of platform driver.

Currently there is no working NDFC driver in the kernel. I felt a
working driver, even if less than optimal, is better than not
supporting NAND on the 44x. This driver is no worse than the
arch/ppc version was, it is just no better ;)

Cheers,
   Sean
