Message-ID: <903E17B6FF22A24C96B4E28C2C0214D7012BB3D8@sr-bng-exc01.int.tsbu.net>
From: "Karoliya, Abhishek" <Abhishek.Karoliya@fci.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: PPC PCI Enumeration::Switch off
Date: Wed, 24 Dec 2003 00:08:58 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi ,

  While porting Linux {we use both flavours MontaVista based on 2.4.18 &
Kernel.org's 2.4.20} on MPC7447(Dual CPU) + MV64360 based Processor PMC
boards , we have a scenario where multiple PMC card will reside on the same
PCI bus . Out of all the boards only one {identified through hardware
signal} will enumerate the rest and other PCI devices on the board. {Monarch
mode}.

  Hence we need to turn off PCI enumeration for other {Non-monarch boards }.
I tried this by  not calling the
pciauto_bus_scan(){arch/ppc/kernel/pci_auto.c} while setting up the host
bridge . But the boards still goes forward and does the enumeration.
Do I have take care of any other section of the code .

Thanks a lot
Abhi


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
