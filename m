Return-Path: <Renaud.Barbier@ge.com>
Received: from ext-ch1gw-6.online-age.net (ext-ch1gw-6.online-age.net
	[64.37.194.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 670AB2BF0A
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Dec 2004 23:39:15 +1100 (EST)
Received: from int-ch1gw-1.online-age.net (int-ch1gw-1 [3.159.232.65])
	by ext-ch1gw-6.online-age.net (8.12.11/8.12.11/20050527-JWF) with ESMTP
	id iB3CAtC2019982
	for <linuxppc-embedded@ozlabs.org>; Fri, 3 Dec 2004 07:10:55 -0500
Received: from cinmlef08.e2k.ad.ge.com (localhost [127.0.0.1])
	by int-ch1gw-1.online-age.net (8.12.9/8.12.3/990426-RLH) with ESMTP id
	iB3CBU4g028641
	for <linuxppc-embedded@ozlabs.org>; Fri, 3 Dec 2004 07:11:31 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 3 Dec 2004 06:12:31 -0600
Message-ID: <45ABD2373C33C4459D42B40EC4F346F2047DC3D4@FTWMLVEM03.e2k.ad.ge.com>
From: "Barbier, Renaud (GE Infrastructure)" <Renaud.Barbier@ge.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: 440GX MMU problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I am using linux 2.4.26 on a 440GX with 512MB of SDRAM.
>From U-boot I can see the whole memory.
If I boot Linux, unless I set the boot parameter mem=3D256M (or less).
it will not boot. Linux does not seem to go further than the MMU_setup.

Any idea why it cannot use 512MB?

thanks.
