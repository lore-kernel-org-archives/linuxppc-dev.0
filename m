Message-ID: <F924CEFBBF62D611A0C600D0B76ED0375C4207@cvxmail.ana.aastra.com>
From: Iain Barker <ibarker@aastra.com>
To: "'Jan Damborsky'" <jan.damborsky@devcom.cz>,
	linuxppc-dev@lists.linuxppc.org
Subject: RE: Ethernets on SCC2 and SCC3 on mpc8xx
Date: Wed, 13 Aug 2003 16:20:09 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The FCC driver on 8260 supports up to 3 Ethernet ports. I don't think there
is any similar on the SCC used on 8xx (just one SCC can run Ethernet in the
standard driver, you choose which SCC) but if you are using 8xx with FEC you
can use one SCC and FEC to give two Ethernet ports on an 8xx.



-----Original Message-----
From: Jan Damborsky [mailto:jan.damborsky@devcom.cz]
Sent: Wednesday, 13 August, 2003 12:39
To: linuxppc-dev@lists.linuxppc.org
Subject: Ethernets on SCC2 and SCC3 on mpc8xx



Hello,

we want to use our custom board with MPC823e as
easy firewall in our applications. We have two 10Mbit ethernet
on board connected to SCC2 and SCC3 channels.
Is it support in kernel
for using both SCC channels configured as ethernet
(eth0, eth1 devices) simultaneously ? I use 2.4.3 kernel
and there is only possibility to use SCC2 or SCC3
as ethernet, not both at the same time.

                           Thanks in advance, HANYS


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
