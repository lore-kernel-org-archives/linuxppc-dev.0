Return-Path: <johnkokko@hotmail.com>
Received: from col0-omc3-s8.col0.hotmail.com (col0-omc3-s8.col0.hotmail.com
	[65.55.34.146]) by ozlabs.org (Postfix) with ESMTP id 38B27B7158
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Sep 2010 22:17:41 +1000 (EST)
Message-ID: <COL120-W4274596E983E02BCBF4AD0A78B0@phx.gbl>
From: Ioannis Kokkoris <johnkokko@hotmail.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: P1021MDS QE Ethernet Ports
Date: Wed, 1 Sep 2010 15:11:56 +0300
Content-Type: text/plain; charset="iso-8859-7"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hello=2C

we are seeing a strange behavior when trying to use the QE Ethernet interfa=
ces.
ENET5 (UCC5 - RMII) interface on P1021MDS boards does not come up if there =
is no physical link on the ENET1 (UCC1 - MII) Port.
It seems that interrupts from ENET5 are normally received but the link come=
s up and works properly only if we have physical connection on ENET1.=20

Can anyone think of a possible reason for this behavior=2C is there a way t=
o trace this problem?
I can provide any further information needed.

Any help would be appreciated=2C
Regards=2C
John

 		 	   		  =
