Message-ID: <6B546A602AD2D211BFF00008C7A428890584409E@hrtades2.atea.be>
From: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
To: "'Gerhard TAEUBL'" <Gerhard.TAEUBL@frequentis.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: 2 Ethernet ports on a MPC860T
Date: Tue, 11 Jun 2002 11:10:31 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I think it should work. In fec.c there is some code that "generates" an
extra MAC address when CONFIG_SCC_ENET is defined....

Fred

-----Original Message-----
From: Gerhard TAEUBL [mailto:Gerhard.TAEUBL@frequentis.com]
Sent: dinsdag 11 juni 2002 9:35
To: linuxppc-embedded@lists.linuxppc.org
Subject: 2 Ethernet ports on a MPC860T



Hi all!

We have to redesign our customer board next year, and there is a requirement
to use two ethernet ports. At the moment we use of course the FEC with
10/100 MBit. So we want to add a SCC (SCC3 fits for us ...) for a second
ethernet. Is that configuration supported by linux, or easy to adapt? (to
switch from another SCC to SCC3 or similar).

What kind of external devices are necessary? And how do you store the MAC
Address? (We do it at the moment via a one wire chip, they garant for the
right MAC Address).

Thanks in advance

Gerhard


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
