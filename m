Date: Fri, 12 Apr 2002 11:29:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Armin <akuster@pacbell.net>, John Tyner <jtyner@cs.ucr.edu>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] early serial init
Message-ID: <20020412012937.GI1786@zax>
References: <Pine.LNX.4.30.0204111424410.10803-100000@hill.cs.ucr.edu> <3CB5A370.4080409@pacbell.net> <20020411230910.GI759@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020411230910.GI759@opus.bloom.county>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Apr 11, 2002 at 04:09:10PM -0700, Tom Rini wrote:
>
> On Thu, Apr 11, 2002 at 02:53:36PM +0000, Armin wrote:
> >
> > John Tyner wrote:
> > >I remember seeing something awhile ago about early boots, but I didn't
> > >think it was for Walnut. Where is it/would it be?
> > >
> >
> > David G did something and he hit the head_4xx.S & ppc4xx_setup.c and a
> > few header files imb405gp.h
>
> Ah, here's some of the confusion.  David G did the work for
> CONFIG_SERIAL_TEXT_DEBUG or so.  What this does is setup
> drivers/char/serial.c dynamically instead of statically.

Indeed, my serial debug patches are unrelated to this
early_serial_init() patch.

Mind you I think setting up the serial subsystem dynamically rather
than statically has the potential to make things a good deal neater
than the current maze of twisty little include files.

However there is a problem at the moment, because early_serial_init()
won't work if serial.o is compiled as a module.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
