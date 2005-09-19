Return-Path: <BLandau@nds.com>
Received: from ILEX2.IL.NDS.COM (jeru1.ndsisrael.com [192.118.34.248])
	by ozlabs.org (Postfix) with ESMTP id E7B3068311
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Sep 2005 01:53:52 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 19 Sep 2005 18:41:39 +0300
Message-ID: <B621B955FA9FBB4C83F9724972F4DD1901CB5421@ILEX2.IL.NDS.COM>
From: "Landau, Bracha" <BLandau@nds.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: 8250 serial driver on MPC8272ADS board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am running linux kernel 2.6.13 on a MPC8272ADS board. When I compile =
the kernel with the 8250 serial driver, the kernel crashes when loading =
it. It crashes also if compiled as a module and insmod'ed later.
Has anyone had experience with this?
Thanks,
Bracha
