Return-Path: <Renaud.Barbier@GE.COM>
Received: from ext-nj2gw-6.online-age.net (ext-nj2gw-6.online-age.net
	[64.14.56.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 67BF12BF45
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Nov 2004 23:40:50 +1100 (EST)
Received: from int-nj2gw-4.online-age.net (int-nj2gw-4 [3.159.236.68])
	by ext-nj2gw-6.online-age.net (8.12.11/8.12.11/990426-RLH) with ESMTP
	id iABBo9Ka015821
	for <linuxppc-embedded@ozlabs.org>; Thu, 11 Nov 2004 06:50:09 -0500
Received: from cinmlef05.e2k.ad.ge.com (localhost [127.0.0.1])
	by int-nj2gw-4.online-age.net (8.12.9/8.12.8/990426-RLH) with ESMTP id
	iABBqFVX015357 for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Nov 2004 06:52:16 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 11 Nov 2004 05:53:06 -0600
Message-ID: <45ABD2373C33C4459D42B40EC4F346F20426886D@FTWMLVEM03.e2k.ad.ge.com>
From: "Barbier, Renaud (GE Infrastructure)" <Renaud.Barbier@GE.COM>
To: <linuxppc-embedded@ozlabs.org>
Subject: linux 2.4.26 on 440GX 512MB of RAM
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I am booting linux from, Uboot on a custom 440GX board.

U-boot is able to access the 512MB of RAM I have on this board.
Unless I add the option mem=3D256M to the linux boot line,=20
linux is not able to fully boot.

I know it calls MMU_init (head_44x.S) but does not seem to jump to =
start_kernel after that.

Is there something I am missing here?=20
