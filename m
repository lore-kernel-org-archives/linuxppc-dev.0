Subject: Re: multiple separate pci bridges ...
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1074503490.4547.52.camel@gaston>
References: <20040118144412.GA6897@iliana> <1074503490.4547.52.camel@gaston>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1074468194.9699.209.camel@thor.asgaard.local>
Mime-Version: 1.0
Date: Mon, 19 Jan 2004 00:23:15 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2004-01-19 at 10:11, Benjamin Herrenschmidt wrote:
>
> > The freeze happens when i first launch glxinfo, or when i first start
> > moving a window around (using a debian/unstable default gnome desktop).
> > I don't remember well, but i think it would also freeze when let running
> > for a time, but i am not sure. The box is still available trough ssh,
> > but killing the X server doesn't restore the fbdev console, and freeze
> > the box.
>
> Could be irq not working...

Only the 3D drivers use the IRQ, it's not involved when moving around
windows. Or do you mean a badly configured IRQ causing a flood or
something?


--
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
