Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it
	(host20-155-static.82-213-b.business.telecomitalia.it
	[213.82.155.20]) by ozlabs.org (Postfix) with ESMTP id 66179DDDA0
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 19:45:32 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: ioremap_nocache on the nor flash, reading sporadically fails
Date: Fri, 27 Mar 2009 09:33:23 +0100
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E013D5B2E@aquib01a>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I have an MPC880 with linux-2.6.19, I use a flash sector of my nor flash
to store some parameters.=20
In order to read them I mapped it with ioremap_nocache and most of the
time the reading is working fine. Sporadically the read returns strange
values...=20
Could it be an hardware problem? Or mapping the flash is not permitted?
Consider that linux is also stored on the flash and it is working fine.
My only doubt is that on the uC bus there is also an fpga that is
activated only after linux hgas started.=20

Bye,
Antonio.
