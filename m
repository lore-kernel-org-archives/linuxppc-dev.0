Date: Wed, 28 Jul 1999 02:18:09 -0400 (EDT)
From: Tom Rini <trini@disparity.net>
To: Daniel Jacobowitz <drow@false.org>
cc: Martin Mares <mj@ucw.cz>,
        "Andre M. Hedrick" <hedrick@Astro.Dyer.Vanderbilt.Edu>,
        linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Trying a Promise Ultra/66 on powerpc
In-Reply-To: <19990727230416.A457@them.org>
Message-ID: <Pine.BSF.3.96.990728021558.16098B-100000@silver.teardrop.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 27 Jul 1999, Daniel Jacobowitz wrote:

> (A) You can't compile IDE as a module and enable ide-pmac.  There will
> be link errors in pmac_setup.c.
> 
> (B) Very closely tied to that, if ide-pmac is not enabled, a dummy
> pmac_ide_init_hwif_ports() is compiled in pmac_setup.c.  But the real
> version of this function (in ide-pmac.c) does more than just onboard
> IDE specific tasks.  For PCI IDE cards it is still needed.  Enabling
> ide-pmac eventually let me make use of the card.

This is because the ide-pmac option is general IDE support and onboard IDE
on the older macs.  It should be setup ALA x86, so that config_ide or
whatever does yes/no to IDE support and ide-pmac is pmac ide driver only.
The module thing was (i think) fixed or atleast worked around a while
back, check the linuxpp.cs.nmt.edu dirs..

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
