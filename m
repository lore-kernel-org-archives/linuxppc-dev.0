Subject: Re: multiple separate pci bridges ...
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1074469340.4547.71.camel@gaston>
References: <20040118144412.GA6897@iliana> <1074503490.4547.52.camel@gaston>
	 <1074468194.9699.209.camel@thor.asgaard.local>
	 <1074469340.4547.71.camel@gaston>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1074470602.9704.235.camel@thor.asgaard.local>
Mime-Version: 1.0
Date: Mon, 19 Jan 2004 01:03:22 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2004-01-19 at 00:42, Benjamin Herrenschmidt wrote:
> >
> > Only the 3D drivers use the IRQ, it's not involved when moving around
> > windows. Or do you mean a badly configured IRQ causing a flood or
> > something?
>
> Oh, you don't use the IRQ for throttling the ring ?

No, that's only rarely needed anyway, if ever (a while ago, I discovered
that the DRM code to detect a full ring had been broken for a while, but
it didn't seem to cause any problems :).

> Only for VBL ?

That, frame throttling (to prevent too many frames getting queued) and
waiting for rendering to finish.


--
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
