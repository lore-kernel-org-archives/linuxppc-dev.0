Mime-Version: 1.0
Message-Id: <a05010404b703232d1b66@[192.168.240.10]>
Date: Wed, 18 Apr 2001 13:04:19 +0200
To: linuxppc-dev@lists.linuxppc.org
From: Alain RICHARD <alain.richard@equation.fr>
Subject: benh 2.4.4-pre3, Titanium and AirPort
Content-Type: text/plain; charset="iso-8859-1" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am currently using Benjamin Herrenschmidt 2.4.4-pre3 kernel on my
Titanium. The only problem I am currently experiencing is that the
kernel PCMCIA i82365.c driver do not recognized the PCI cardbus
adaptator.

Is there any solution (patch) to get it recognized ?

Also as the current airport driver is now based on the orinoco_cs
(and hermes) driver that depends on PCMCIA support, I am unable to
get airport working. Is there any solution to get it working without
PCMCIA ?

--
-------------------------------------------------------
Alain RICHARD <mailto:alain.richard@equation.fr>
EQUATION SA <http://www.equation.fr/>
Tel : +33 477 79 48 00	 Fax : +33 477 79 48 01
Applications client/serveur, ingénierie réseau et Linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
