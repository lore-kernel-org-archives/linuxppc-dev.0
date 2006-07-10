Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 8E59567C2D
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jul 2006 06:38:09 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: FW: ppc -> powerpc porting
Date: Mon, 10 Jul 2006 15:38:08 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0189DE61@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> From: Vitaly Bordug [mailto:vbordug@ru.mvista.com]=20
> Sent: Monday, July 10, 2006 12:42
> We have mpc8272 under arch/powerpc as work-in-progress,=20
> latest fs_enet being merged now.
>=20
> I think it'll be a week or 2 before first submit, so it may=20
> make sense just to wait a bit :)

Ok. I sor of used the ppc version of the 8272 to get fs_enet working.=20
fs_enet is not my main concern. My concern is everything else... OF
tree, new IRQ code (we have two local IRQ muxes in FPGA modeled afrer
the PCI mux on 8266ADS). Our current port is running on 2.6.12. We have
a 2.6 17 port working, but have not started using it yet. I want to wait
until we have ported to powerpc/=20
