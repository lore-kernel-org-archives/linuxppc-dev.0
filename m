Date: Thu, 13 Sep 2001 14:41:43 +0200
From: Xavier Grave <grave@ipno.in2p3.fr>
To: dev ppc <linuxppc-dev@lists.linuxppc.org>
Subject: mvme5100 hawk configuration problem ?
Message-ID: <20010913144143.A4634@ipnpcu5.in2p3.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have two board with a 2.4.10 kernel (bk tree) :
on the mvme2303 cat /proc/iomem gives :
c0000000-feffffff : PCI host bridge
  effeef80-effeefff : Digital Equipment Corporation DECchip 21140
[FasterNet]
  effef000-effeffff : Tundra Semiconductor Corp. CA91C042 [Universe]
  fc000000-fc03ffff : Motorola Raven
on the mvme5100 cat /proc/iomem gives :
00000000-ffffffff : <BAD>
  f3f00000-f3f1ffff : Intel Corporation 82559ER (#2)
  f3f3d000-f3f3dfff : Intel Corporation 82559ER (#2)
    f3f3d000-f3f3dfff : eepro100
  f3f3e000-f3f3efff : Symbios Logic Inc. (formerly NCR) 53c895
  f3f3ff00-f3f3ffff : Symbios Logic Inc. (formerly NCR) 53c895
  f3f40000-f3f5ffff : Intel Corporation 82559ER
  f3f7e000-f3f7efff : Intel Corporation 82559ER
    f3f7e000-f3f7efff : eepro100
  f3f7f000-f3f7ffff : Tundra Semiconductor Corp. CA91C042 [Universe]

I have written a module driver for the vme chip real-time and non-real-time
(it is very inspired from the one from
Gabriel Paubert), the modules load without problem on the mvme 2303 but not
on the mvme5100 ?
Any idea of the problem ? I will have a look on the mvme5100_setup.c and
mvme5100_pci.c files.

O+ xavier

--
33 (0) 1 69 15 79 59
De chacun selon ses forces, a chacun selon ses besoins

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
