Date: Wed, 26 Apr 2000 08:53:07 +0200 (CEST)
From: Geir Frode Raanes <geirfrs@invalid.ed.ntnu.no>
To: Ralph Blach <rcblach@raleigh.ibm.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Video Card with PowerPC initialization Code
In-Reply-To: <3905A4C9.7C58472E@raleigh.ibm.com>
Message-ID: <Pine.BSF.4.10.10004260843060.60450-100000@invalid.ed.ntnu.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 25 Apr 2000, Ralph Blach wrote:

> Does anybody know of Video card which has a ROM that has PowerPC
> initializaiton in it?  If so, what is it?

They don't.

PowerPC desktop systems usually comes with Open Firmware
(aka. OpenBoot on SPARC) wich requires expansion ROMs to
be in CPU neutral Forth code, compiled runtime.
Hence, VGA BIOS does not apply.

> Chip
> IBM MicroElectronics

Errr - Don't you have a RS6000 division nearby you can bug?

--
  ******************************************************
  Never ever underestimate the power of human stupidity.
  -Robert Anson Heinlein

		GeirFRS@invalid.and.so.forth
  ******************************************************


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
