Date: Thu, 11 Apr 2002 16:09:10 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Armin <akuster@pacbell.net>
Cc: John Tyner <jtyner@cs.ucr.edu>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] early serial init
Message-ID: <20020411230910.GI759@opus.bloom.county>
References: <Pine.LNX.4.30.0204111424410.10803-100000@hill.cs.ucr.edu> <3CB5A370.4080409@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CB5A370.4080409@pacbell.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Apr 11, 2002 at 02:53:36PM +0000, Armin wrote:
>
> John Tyner wrote:
> >I remember seeing something awhile ago about early boots, but I didn't
> >think it was for Walnut. Where is it/would it be?
> >
>
> David G did something and he hit the head_4xx.S & ppc4xx_setup.c and a
> few header files imb405gp.h

Ah, here's some of the confusion.  David G did the work for
CONFIG_SERIAL_TEXT_DEBUG or so.  What this does is setup
drivers/char/serial.c dynamically instead of statically.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
