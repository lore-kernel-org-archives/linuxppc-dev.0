Message-ID: <390690B1.1194EC88@rd.francetelecom.fr>
Date: Wed, 26 Apr 2000 08:46:09 +0200
From: FASSINO Jean-Philippe <jeanphilippe.fassino@rd.francetelecom.fr>
MIME-Version: 1.0
To: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>
CC: LinuxPPC <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Dual head on a Powerbook
References: <3906199F.1D7F995@dana.ucc.nau.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tim Wojtulewicz wrote:

> I'm trying to connect a projector to the monitor port on the back of my
> powerbook, so I can do a presentation with it.  Anyone have any
> information on dual headed support on powerbooks?  Pismo, LinuxPPC2000,
> 2.2.15pre19

I'm doing this using Xpmac and booting with BootX.
First configure external display to be primary in MacOS (be
careful with depth color !).
Next, start Linux which display on external monitor.
This method work only with Xpmac and not with FBDev (3.3.x).

JP


--
--------------------------------------------------------------------------
 Jean-Philippe FASSINO              France Telecom R&D : DTL/ASR
 Tel : 04 76 76 45 52
 mailto:jeanphilippe.fassino@francetelecom.fr
--------------------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
