Date: Mon, 3 Sep 2001 19:23:22 +0200
From: Jure Menart <jure@kom.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: kernel course no. 1
Message-ID: <20010903192322.A1346@hannanges.teden-mladih.com>
References: <20010830170937.A21057@hannanges.teden-mladih.com> <20010830152904.15461@smtp.adsl.oleane.com> <20010902235527.A745@hannanges.teden-mladih.com> <15250.46650.425731.282840@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15250.46650.425731.282840@cargo.ozlabs.ibm.com>; from paulus@samba.org on Mon, Sep 03, 2001 at 08:44:10AM +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
On Mon, Sep 03, 2001 at 08:44:10AM +1000, Paul Mackerras wrote:
> > OK, thanks for information (I presumed that it is 'catch' with rfi :-), but
> > I've got problem with booting my kernel anyway. I was wondering why would
> > booting stop when this 'rfi' occurs...
>
> How do you know that it stops there exactly?

well, I have two LEDs on my board for 'very hardware debug' (I know it's VERY
cheap, but it's very useful too ;-), so I try to turn one LED on before the
jump ('rfi' call) and another at the beginning of 'start_here' procedure. As
you can guess - first LED turned on but second didn't.

Any idea? Could be something wrong with my cross-compiler? Initialization of
MMU? Stack?
I'm pretty much down on this :-(

Regards, Jure


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
