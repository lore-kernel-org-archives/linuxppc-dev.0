From: matik@ug.bilkent.edu.tr
Message-ID: <BasiliX-1.1.0-108731023640cf099ce2530@postaci.ug.bilkent.edu.tr>
Date: Tue, 15 Jun 2004 17:37:16 EEST
Reply-To: matik@ug.bilkent.edu.tr
Subject: MPC8260 ethernet transmit problem
To: linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I am using Windriver SBCPowerQUICC2 with MPC8265 on it with 2.4.26 kernel. When I configure FCC ethernet on one of FCC1/2/3 it does not transmit any packet through channel although it successfully calls 'fcc_enet_xmit' function.
Note: reception works.

Thanks.
matik

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
