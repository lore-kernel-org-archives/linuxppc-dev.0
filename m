Message-ID: <39043F06.CDED1B99@pop.agri.ch>
Date: Mon, 24 Apr 2000 14:33:13 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Bernhard Reiter <bernhard@intevation.de>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Serial driver problem (modem Lombard)
References: <20000422123747.B8503@cheops.usf.Uni-Osnabrueck.DE> <3901D09B.4B25722F@pop.agri.ch> <20000424125228.A15804@cheops.usf.Uni-Osnabrueck.DE>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Bernhard Reiter wrote:
>
> > Now I can report a clean, more or less, well ppp operation.
> As I wrote, it always works on the first try.
> It sometimes fials on the second and following tries with 2.2.15pre19.
> It always works with the 2.2.15pre3 which does not have ir support build
> in.

I'm not sure, is it possible to disable IR in the kernel build? worth a try.

> If wvdialconf scans the ir port ttyS1 on 2.2.15pre19, die machine bombs.

have you tried with something other than wvdial? (which I don't know), I
use netcfg.

> > > wvdail cannot open /dev/ttyS0 twice with 2.2.51pre19.
> > > After I ctrl-ced wvdial to interrupt the network connection
> > > I get an I/O error when I try to open it again.
> >
> > Do you have the module option in char/devices/serial on? (dumb serial device)
>
> Not that I know of. I admit that I have to learn a bit more about
> kernel configuration to be sure, though.

This makes only sense when you have a pcmcia/cadbus modem.

> Most interestingly right now I cannot reproduce the I/O error.
> So it works, most of the time. I hate this kind of errors.
> So a hardware problem is still possible with this machine.

:-((

Andreas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
