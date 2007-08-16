Return-Path: <Haiying.Wang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C11C0DDE32
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Aug 2007 00:19:08 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l7GEJ3qS025938 for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Aug 2007 07:19:03 -0700 (MST)
Received: from az33exm23.fsl.freescale.net (az33exm23.am.freescale.net
	[10.64.32.8])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l7GEJ2Ki028993
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Aug 2007 09:19:02 -0500 (CDT)
Subject: Re: My Kernel hangs after images verification and no boot msgs on
	Console?
From: Haiying Wang <Haiying.Wang@freescale.com>
To: dnl <ssaravanan@mail2web.com>
In-Reply-To: <F3D55679E1DCFF49A57570501B70475F070D83B5@CL5EXBE04.ad2.softcom.biz>
References: <8779714.1620021187264042248.JavaMail.nabble@isper.nabble.com>
	<F3D55679E1DCFF49A57570501B70475F070D83B5@CL5EXBE04.ad2.softcom.biz>
Content-Type: text/plain
Date: Thu, 16 Aug 2007 10:19:00 -0400
Message-Id: <1187273941.3034.2.camel@udp097531uds.am.freescale.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2007-08-16 at 07:40 -0400, dnl wrote:
> 

>  1. i can view the booting messages by "Dumping the printk Log
> Buffer".
>  2. i am passing the "bootargs=console=ttyS0,115200 root=/dev/ram0 rw"
> 
> How can i get boot messages on serial console?
> 
Set console = ttyS1,115200 instead of ttyS0.
