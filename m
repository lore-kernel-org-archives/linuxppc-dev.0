Return-Path: <jbe@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id CD572DE0C4
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 17:57:48 +1000 (EST)
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Date: Mon, 25 May 2009 09:56:27 +0200
References: <20090523231148.17919.46103.stgit@terra>
	<20090524185509.GA3561@pengutronix.de>
	<9e4733910905241310n59952fd2oaafd7f1363db324@mail.gmail.com>
In-Reply-To: <9e4733910905241310n59952fd2oaafd7f1363db324@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200905250956.28206.jbe@pengutronix.de>
Subject: Re: [PATCH V2 5/9] Main rewite of the mpc5200 audio DMA code
Cc: alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon,

On Sonntag, 24. Mai 2009, Jon Smirl wrote:
> On Sun, May 24, 2009 at 2:55 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> >> Rewrite the mpc5200 audio DMA code to support both I2S and AC97. Make it
> >> more robust.
> >
> > Why is it more robust?
>
> I've implemented retries for when the AC97 hardware doesn't reset on
> first try. About 10% of the time both the Efika and pcm030 AC97 codecs
> don't reset on first try and need to be poked multiple times.  Failure
> is indicated by not having the link clock start ticking. Every once in
> a while even five pokes won't get the link started and I have to power
> cycle.

Do you know this (from our website)?

"The AC97 mixer needs a hardware patch to make it wake up from power down 
mode. Download here the instruction how to do so."

http://www.pengutronix.de/oselas/bsp/phytec/download/phyCORE-MPC5200B-tiny/TN-015e_1.pdf

jbe

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-8766-939 228     |
Vertretung Sued/Muenchen, Germany             | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
