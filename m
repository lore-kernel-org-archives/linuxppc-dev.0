Return-Path: <david-b@pacbell.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E9370B7120
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 11:43:44 +1000 (EST)
Received: from n21.bullet.mail.mud.yahoo.com (n21.bullet.mail.mud.yahoo.com
	[68.142.206.160]) by ozlabs.org (Postfix) with SMTP id 40A6ADDD0B
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2009 11:43:44 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: spi-devel-general@lists.sourceforge.net,
 Rini van Zetten <rini@arvoo.nl>
Subject: Re: [spi-devel-general] [PATCH -mm v4][POWERPC] mpc8xxx : allow SPI
	without cs.
Date: Thu, 2 Jul 2009 18:38:03 -0700
References: <4A39DC80.7030906@arvoo.nl>
	<20090619134558.GA18872@oksana.dev.rtsoft.ru>
	<4A3B9E38.9060004@arvoo.nl>
In-Reply-To: <4A3B9E38.9060004@arvoo.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200907021838.03375.david-b@pacbell.net>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 19 June 2009, Rini van Zetten wrote:
> This patch adds the possibility to have a spi device without a cs.

Note that there's now the SPI_NO_CS bit in spi_device.mode
to describe this situation ... so no "-EEXIST" hackery should
ever tempt anyone again.
