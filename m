Message-Id: <5.1.1.6.0.20030528113555.01acc0a8@dns.struinfo.it>
Date: Wed, 28 May 2003 11:42:01 +0200
To: linuxppc-embedded@lists.linuxppc.org
From: llandre <r&d@wawnet.biz>
Subject: Driver for STE100P (Ethernet PHY)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I'm developing a PPC405EP-based board with the ST STE100P chip as Ethernet
PHY. Unfortunately this is not supported by the current driver
(drivers/net/ibm_ocp/ibm_ocp_phy.c). Anybody has a patch to add the support
for it?

Thanks in advance.


llandre


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
