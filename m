Message-ID: <207ED16333297540B90E2C3F0BA95F0949CFF5@XCH-SW-02.ds.boeing.com>
From: "Larsen, Kent B" <Kent.Larsen@West.Boeing.com>
To: "'Prasad, Siva'" <Siva.Prasad@smartm.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: HHL 2.0 with force-pcore680 LSP
Date: Thu, 11 Oct 2001 16:09:02 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


load the motorola-sandpoint
and then from make menuconfig select:
Platform support->Processor Type (6xx/7xx/74xx/82xx) and
Platform support->Machine Type (Force-PowerCore)

The board type is selected in pcore_pci.c (in arch/ppc/kernel)
depending on which bridge is detected.

-Kent

-----Original Message-----
From: Prasad, Siva [mailto:Siva.Prasad@smartm.com]
Sent: Thursday, October 11, 2001 10:21 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: HHL 2.0 with force-pcore680 LSP



Hi,

Where can I find the cdimage for HHL 2.0 with force-pcore680 LSP.
Information about force-pcore6750 would also be great.

I downloaded the je-d2-hhl2.0.cdimage (Journeyman CD2 image) from mvista.com
ftp site. But it has only Sandpoint and rpxlite LSP's.

Can some one point me to place where I can download HHL 2.0 with
force-pcore680 LSP.

-- Siva


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
