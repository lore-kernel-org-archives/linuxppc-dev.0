Message-ID: <391144BB.F583410B@mpifr-bonn.mpg.de>
Date: Thu, 04 May 2000 11:36:59 +0200
From: Albrecht Dre_ <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
CC: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: Re: FireWire chip on PISMO?
References: <Pine.LNX.3.96.1000503235136.6574O-100000@deepspace.mklinux.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"David A. Gatwood" wrote:
> It's a standard OHCI chip, probably repackaged in a custom ASIC, but it
> works with the same drivers as all the other OHCI devices.  You should
> only need to add an extra ID in your supported device lists for the linux
> drivers to support it.  If the driver doesn't work out of the box, there's
> a driver bug in general.  :-)

This first "quick hack" to the ohci driver lead to a kernel panic...  Sigh!
I'll have to try in more depth...

Thanks anyway, Albrecht.

--
+-----------------------------------------------------------------------------+
| Dr.-Ing. Albrecht Dre\ss                                     """"           |
| Max-Planck-Institut f\"ur Radioastronomie   |\       /      /o  o\          |
| Abteilung f\"ur Infrarot-Interferometrie    |  \    /      |  /   |         |
| Auf dem H\"ugel 69                          |    \ |        \ ---/          |
| D-53121 Bonn (Germany)          ------------+------+-------------------     |
| Phone (+49) 228 525 319                     |    / |                        |
| Fax   (+49) 228 525 411                     |  /  /                         |
| Mail  ad@mpifr-bonn.mpg.de                  |/   /                          |
| http://www.mpifr-bonn.mpg.de/div/iri                                        |
+-------------- electrical engineers do it with less resistance --------------+

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
