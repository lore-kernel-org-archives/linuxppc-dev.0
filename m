Reply-To: <ldu@solectek.com>
From: "Leiying Du" <ldu@solectek.com>
To: "'LinuxPPC-Embedded'" <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC860 Ethernet Problem
Date: Thu, 15 Aug 2002 10:42:52 -0700
Message-ID: <DDEMKFCKCAHJDIFEOONBGEDOCAAA.ldu@solectek.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
  I have an MPC860 broad with AMD79C874 PHY. The FEC is used as the MAC
controller. I have a problem that some switches will treat the IDLE code
sending from the broad's Ethernet port as normal data when the Ethernet is
set to 100Mbps. So the traffic hardly can pass those switches. Does anyone
has the experience on this?  Thanks,

Leiying


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
