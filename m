Return-Path: <saso@activetools.si>
Received: from netgate.activetools.si (router.activetools.si [213.250.28.33])
	by ozlabs.org (Postfix) with ESMTP id E0E152BE83
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Dec 2004 21:08:07 +1100 (EST)
Received: from foo.at.lan ([172.16.88.10] helo=foo)
	by netgate.activetools.si with esmtp (Exim 3.35 #1 (Debian))
	id 1CdmfI-000862-00
	for <linuxppc-embedded@ozlabs.org>; Mon, 13 Dec 2004 10:38:48 +0100
Received: from mayhem.at.lan ([172.16.88.115])
	by foo with esmtp (Exim 3.35 #1 (Debian)) id 1CdmfI-0006Uw-00
	for <linuxppc-embedded@ozlabs.org>; Mon, 13 Dec 2004 10:38:48 +0100
Message-ID: <41BD637E.3000106@activetools.si>
Date: Mon, 13 Dec 2004 10:40:14 +0100
From: Saso Kavcic <saso@activetools.si>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: fcc_enet driver in linux 2.6.9
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I am new to working in embedded linux applications and would appreciate 
a little help.
We are porting linux to a custom mpc8275 board and we are having some 
difficulties
with the fcc ethernet driver. Does anyone know if the fcc enet driver in 
linux 2.6.9
kernel works and if it works if the kernel is compiled preemptible. We 
are trying to
boot the kernel with dhcp, but the network seems very slow and 
unreliable and this
only with "preemptible kernel" option disabled. We are using mpc8275VR 
and LXT972A
PHY, could this be the cause for trouble.

Best Regards, Saso
