Message-ID: <38C98B3D.AB06EE7E@iiic.ethz.ch>
Date: Sat, 11 Mar 2000 00:54:37 +0100
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        Kostas Gewrgiou <gewrgiou@imbc.gr>, linuxppc-dev@lists.linuxppc.org
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on
 ppcwithr128
References: <Pine.LNX.4.10.10003101940550.9648-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:

> > I am confused.  Now that XF 4.0 is out, will quick snapshots continue to
> > be released?
>
> One would sure hope so. The 4.0 X server dies horribly during device
> configuration on my Lombard. After feeding it a hand-crafted XF86Config,
> it just hangs the machine.

Which driver?

With the fbdev driver, you have to specify the bus ID of the graphics chip,
e.g.

    BusID	"0:1:0"


Michel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
