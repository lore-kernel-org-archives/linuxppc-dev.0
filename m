Return-Path: <dtor_core@ameritech.net>
Received: from smtp103.sbc.mail.re2.yahoo.com (smtp103.sbc.mail.re2.yahoo.com
	[68.142.229.102]) by ozlabs.org (Postfix) with SMTP id 36370688D6
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Dec 2005 11:52:13 +1100 (EST)
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 24 Dec 2005 19:52:09 -0500
References: <111520052143.16540.437A5680000BE8A60000409C220076369200009A9B9CD3040A029D0A05@comcast.net>
	<20051224231928.GC2183@elf.ucw.cz>
	<1135470801.6387.1.camel@localhost.localdomain>
In-Reply-To: <1135470801.6387.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200512241952.10687.dtor_core@ameritech.net>
Cc: Parag Warudkar <kernel-stuff@comcast.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org,
	Pavel Machek <pavel@ucw.cz>
Subject: Re: PowerBook5,8 - TrackPad update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 24 December 2005 19:33, Benjamin Herrenschmidt wrote:
> 
> > It should be doable once in gpm, all other apps can use gpm's repeater
> > mode...
> > 
> > > When it's in raw mode for use by the synaptics X driver, if course, it's
> > > expected that those things are to be done by that driver.
> > 
> > ...but you are right, doing it in /dev/input/mice emulation layer
> > makes some sense. OTOH I thought we were moving away from
> > /dev/input/mice... Its Dmitry's call I guess.
> 
> Heh, yes, it is. No hurry anyway, I finally got synaptics working
> properly in X ...
> 
> Why would we move away from the mouse mux ? It's proven to be very
> useful to me at least :)
>

It is very limited - number of buttons, wheels, etc. Once X supports
hotplugging mouse multipexor outgrows its usefullness (GPM can simply
be restarted every time we detect new input device).

-- 
Dmitry
