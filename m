Subject: Re: ppc64: Add the Kconfig & Makefile changes related to the
	PowerMac G5 merge
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.GSO.4.58.0402151201470.22078@waterleaf.sonytel.be>
References: <200402120609.i1C69SwG020565@hera.kernel.org>
	 <Pine.GSO.4.58.0402151201470.22078@waterleaf.sonytel.be>
Content-Type: text/plain
Message-Id: <1076843399.6958.52.camel@gaston>
Mime-Version: 1.0
Date: Sun, 15 Feb 2004 22:10:00 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2004-02-15 at 22:04, Geert Uytterhoeven wrote:
> 	Hi Ben,
>
> On Thu, 12 Feb 2004, Linux Kernel Mailing List wrote:
> > ChangeSet 1.1622.2.3, 2004/02/12 14:53:14+11:00, benh@kernel.crashing.org
> >
> > 	ppc64: Add the Kconfig & Makefile changes related to the PowerMac G5 merge
> >
> > @@ -93,7 +93,7 @@
> >
> >  config ADB_MACIO
> >  	bool "Include MacIO (CHRP) ADB driver"
> > -	depends on ADB && !POWER4
> > +	depends on ADB && PPC_PMAC && !PPC_PMAC64
>                           ^^^^^^^^
> Is that correct? Shouldn't that be PPC_CHRP?

Hrm... right, feel free to provide a patch, I'm too tired right now :)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
