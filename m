Return-Path: <morelli.gab@libero.it>
Received: from smtp0.libero.it (smtp0.libero.it [193.70.192.33])
	by ozlabs.org (Postfix) with ESMTP id 7552467BC3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Jun 2006 00:48:37 +1000 (EST)
Received: from localhost (172.16.1.212) by smtp0.libero.it (7.0.027-DD01)
	id 446C5C4E02A1BB92 for linuxppc-embedded@ozlabs.org;
	Wed, 28 Jun 2006 16:48:35 +0200
Received: from smtp3.libero.it ([172.16.1.53])
	by localhost (asav6.libero.it [193.70.192.40]) (amavisd-new, port 10024)
	with ESMTP id 21302-03-35 for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Jun 2006 16:48:34 +0200 (CEST)
Received: from libero.it (192.168.17.8) by smtp3.libero.it (7.0.027-DD01)
	id 44755DBA0086BCB0 for linuxppc-embedded@ozlabs.org;
	Wed, 28 Jun 2006 16:48:34 +0200
Date: Wed, 28 Jun 2006 16:48:34 +0200
Message-Id: <J1KRSY$2A22F25EF5BB111FA515FFA9A4DCCD71@libero.it>
Subject: block after "io scheduler noop registered"
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "morelli\.gab" <morelli.gab@libero.it>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

i,m upgrading the linux kernel 2.4 from 2.6, during the phase of restart =
on my card the system blocks on message "io scheduler noop registered".
the board mount MPC875 processor


...
Serial: CPM driver $Revision: 0.01 $
ttyCPM0 at MMIO 0xf0000a80 (irq =3D 20) is a CPM UART
ttyCPM1 at MMIO 0xf0000a90 (irq =3D 19) is a CPM UART
io scheduler noop registered



Thanks,
