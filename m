Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 67E05B7089
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Jul 2009 22:47:50 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C89CDDDD1B
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2009 22:47:49 +1000 (EST)
Subject: Re: Best hardware platform for native compiling...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20090721120007.GA23164@iram.es>
References: <200907211116.52963.david.jander@protonic.nl>
	<20090721095251.GG32034@lisas.de>
	<200907211231.37299.david.jander@protonic.nl>
	<20090721120007.GA23164@iram.es>
Content-Type: text/plain
Date: Tue, 21 Jul 2009 22:47:39 +1000
Message-Id: <1248180459.31121.9.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Jander <david.jander@protonic.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-07-21 at 14:00 +0200, Gabriel Paubert wrote:
> Well, I got one recently here in Spain. Shipping charges are fairly 
> large (it's not exactly a light and compact machine). But the current 
> dollar exchange rate helps ;-)
> 
> Now I have not yet found the way to install Debian on it
> (it refuses to boot Debian's CDROM), but I have not had
> time to investigate either.

It uses SLOF which should be capable of decent netbooting, so it should
be possible to either netboot yaboot and have it load the kernel and
initramfs, or maybe make a zImage with both included and netboot that.

Cheers,
Ben.
