Date: Tue, 13 Apr 2004 12:36:38 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Aaron Lunansky <muffin@csclub.uwaterloo.ca>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.6.5/iBook G3: Oops on resume from sleep
In-Reply-To: <1081378171.1380.68.camel@gaston>
Message-ID: <Pine.LNX.4.44.0404131235420.21220-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > seems to fail to sleep, and this is regardless of modules (I have
> > sound/airport/ethernet compiled as modules). By fails to sleep, I mean I
> > get a blank screen and it does not respond to any input. I'm not sure
> > where it is when it dies though - what's the best way to figure this
> > out? (how can I make SysRq work on an ibook (which has no SysRq key)).
>
> No, once the screen is off, there isn't much you can do. I suggest
> you do some experiments in console mode, use "snooze -f" (that will
> bypass pmud or pbbuttonsd, which tend to cut the backlight early).

The latest Debian pmud doesn't play with backlight anymore (as per your
bug report), rather leaves backlight control to the kernel.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
