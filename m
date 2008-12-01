Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 43834DDDDF
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 06:48:23 +1100 (EST)
Message-ID: <49343F76.3060802@freescale.com>
Date: Mon, 01 Dec 2008 13:48:06 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Andr=E9_Schwarz?= <Andre.Schwarz@matrix-vision.de>
Subject: Re: i2c-mpc clocking scheme
References: <492EB606.9020703@matrix-vision.de>
	<ed82fe3e0811270724t26d2a8e2v233143722eb8587f@mail.gmail.com>
	<492EC031.9000802@matrix-vision.de>
	<Pine.LNX.4.64.0811281255001.12483@t2.domain.actdsltmp>
	<4933FBC6.50100@freescale.com> <49343DC2.3070601@matrix-vision.de>
In-Reply-To: <49343DC2.3070601@matrix-vision.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Trent Piepho <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

André Schwarz wrote:

> Wouldn't it be easier to omit frequency re-programming at all ?
> Maybe configurable for non U-Boot users ...

Well, the real problem is that Linux is ignoring what the boot loader has done.
 This is bad, regardless as to which boot loader you're using.

The question is, do we give Linux the capability to program the I2C bus speed,
or is this something that the boot loader should do?  Unfortunately, the current
Linux code means that this issue is not properly architected.

You mentioned people who don't use U-Boot.  Do they use some other boot loader?
 Or no boot loader at all?  Do other boot loaders program the I2C bus speed?
The reason I ask is that I want to know whether it's okay for Linux to ignore
the FDR and DFSRR registers.

-- 
Timur Tabi
Linux kernel developer at Freescale
