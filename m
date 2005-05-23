Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 189EB679E6
	for <linuxppc-dev@ozlabs.org>; Tue, 24 May 2005 09:42:17 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tom Parker <palfrey@tevp.net>
In-Reply-To: <429237EC.4010104@tevp.net>
References: <429237EC.4010104@tevp.net>
Content-Type: text/plain
Date: Tue, 24 May 2005 09:41:33 +1000
Message-Id: <1116891693.30513.3.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Reading DVDs on a Mac mini
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-05-23 at 22:07 +0200, Tom Parker wrote:

> 
> The version of libdvdread in use is 0.9.4 (the Debian 0.9.4-5 
> libdvdread3 package).
> 
> hdparm settings for /dev/hdb (the DVD/CD-ROM drive):
> 
>   IO_support   =  0 (default 16-bit)
>   unmaskirq    =  1 (on)
>   using_dma    =  0 (off)
>   keepsettings =  0 (off)
>   readonly     =  0 (off)
>   readahead    = 256 (on)
>   HDIO_GETGEO failed: Invalid argument
> 
> hdparm -i says the drive is a "MATSHITACD-RW CW-8124".
> 
> Any ideas? Because I'm all out of ideas, and I hope someone on here can 
> help.

Does the debian package of libdvdread contains the CSS stuff ? Also, the
lack of "using_dma" is annoying... It looks like our CD/DVD kernel
driver is still dumb and still switches DMA off on any stupid error...

Have you tried booting OS X and playing the DVD once ? Maybe the drive
wants a zone to be set at least once, which MacOS does the first time
you play a DVD

Ben.
