Date: Fri, 14 Jul 2000 19:33:02 +0200 (MET DST)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: switching consoles
Message-ID: <Pine.SOL.3.95.1000714193210.28063B-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 14 Jul 2000 12:24:28 +0200, Martin Costabel <costabel@wanadoo.fr> wrote:
>
> Iain Sandoe wrote:
> >
> > anyone know the magic keys to switch consoles on linuxppc?
> > <alt>-fnX doesn't work for me...
> > Iain.
>
> Depending on your kernel, your configuration and the phase of the moon,
> the <alt> key is sometimes the key labelled "alt" and sometimes the
> "apple" key (aka "command"). And sometimes it is completely disabled.
>
> In X, you use control-command-fnX, and on the i- and powerbooks you have
> to press the keys in a certain order to make it work (first
> control-command, then fn, then fnX, IIRC).
>
Aah, order matters! I had some problems with that in recent kernels, too.
Generally, however, I prefer to set the primary function of the F[1-12]
keys to "Function keys" in the "Options" of the "Keyboard" Control Panel.
BTW, this seems to be reset whenever my OF variables are set back to defaults.
Does anyone know if it is possible to change this setting in OF directly?

Greetings,
							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
