Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B4EC1DDDFA
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 13:07:22 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n3U371mi011310
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 20:07:12 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n3U370AL024858
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 22:07:01 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: USB does not work on mpc8347
Date: Thu, 30 Apr 2009 11:06:59 +0800
Message-ID: <3A45394FD742FA419B760BB8D398F9ED3CB529@zch01exm26.fsl.freescale.net>
In-Reply-To: <200904300112.AA00771@cj3020122-b.jcom.home.ne.jp>
References: <3A45394FD742FA419B760BB8D398F9ED2FAE0B@zch01exm26.fsl.freescale.net>
	<200904300112.AA00771@cj3020122-b.jcom.home.ne.jp>
From: "Li Yang-R58472" <LeoLi@freescale.com>
To: "yamazaki" <yamazaki-seiji@jcom.home.ne.jp>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>Hi Leo
>
>USB work on mpc8347 now.
>Thank you for your help.
>The cause was Clock signal was not connected to USB.
>
>And I have the other problem.
>I need to java run time environment on mpc8347.
>I do not know where i can get it.
>Could you tell me if you know.

I have no particular knowledge about installing JRE on Linux.  Google
leads me to this link which might be helpful: http://openjdk.java.net/

- Leo
