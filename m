Mime-Version: 1.0
Message-Id: <p04320403b57cee530fee@[192.168.240.10]>
Date: Mon, 26 Jun 2000 13:39:03 +0200
To: linuxppc-dev@lists.linuxppc.org
From: Alain RICHARD <alain.richard@equation.fr>
Subject: iBook and Kernel 2.2.17pre7
Content-Type: text/plain; charset="iso-8859-1" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have just made some tests to the kernel 2.2.17pre7 stable from
linuxcare on my iBook :

- The atyfb driver now recognize my iBook ATI Mobility 3D Rage L
chipset. The only problem I have with it is that the initialisation
mode detection is bad and you have to issue a "vmode 10" to get it
working properly.

- The gmac ethernet driver now is able to do promiscuous mode
(tcpdump) and Appletalk.

I hope to be able to run XFree 4.0 or 4.0.1 at least with the fb
driver (it seems that the ati driver in XFree do not recognize the
ATI Mobility 3D Rage L chipset).

Regards,
--
-------------------------------------------------------
Alain RICHARD <mailto:alain.richard@equation.fr>
EQUATION SA <http://www.equation.fr/>
Tel : +33 477 79 48 00	 Fax : +33 477 79 48 01
Applications client/serveur, ingénierie réseau et Linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
