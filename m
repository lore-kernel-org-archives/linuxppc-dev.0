Date: Fri, 10 Sep 1999 11:42:38 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: "David D. Kilzer" <ddkilzer@computer.org>
cc: Martin Costabel <costabel@wanadoo.fr>, Shaw Terwilliger <sterwill@io.nu>,
        Hugh Caley <hcaley@loomer.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Paul's devel branch on Lombard?
In-Reply-To: <v03130303b3fdfbeb11d0@[192.168.1.1]>
Message-ID: <Pine.LNX.4.10.9909101142001.23282-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 9 Sep 1999, David D. Kilzer wrote:
> Martin Costabel wrote:
> 
> >2.3.17 is now running, although I had to recompile it once; make
> >oldconfig had eaten my CONFIG_ADBMOUSE. Someone is playing games with
> >the config options. In make menuconfig, the "APPLE DESKTOP MOUSE" is
> >marked as "NEW". Mine doesn't look very new anymore :-)
> 
> It probably changed to CONFIG_ADB_MOUSE.  This may be a side-effect of the
> ADB merger between Linux/m68k and LinuxPPC.

Always run `make oldconfig' after updating your kernel sources, to make sure
you catch the new options.

Greetings,

						Geert

--
Geert Uytterhoeven ----------------- SONY Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Phone +32-2-7248608 Fax +32-2-7242686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
