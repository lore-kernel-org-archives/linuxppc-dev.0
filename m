Date: Fri, 9 Apr 2004 09:47:48 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.6.5/iBook G3: Oops on resume from sleep
Message-ID: <20040409134748.GA11157@csclub.uwaterloo.ca>
References: <20040405215318.GA2822@mortadelo.pirispons.net> <20040407191719.GA4852@csclub.uwaterloo.ca> <1081378171.1380.68.camel@gaston> <20040408131404.GA28251@csclub.uwaterloo.ca> <1081490612.1382.125.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1081490612.1382.125.camel@gaston>
From: muffin@csclub.uwaterloo.ca (Aaron Lunansky)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


What I was saying is the system doesn't seem to crash, but ends up in a bad state.
The system doesn't make it to sleep (the led does not 'snore').

Did I miss anything?

Thanks,
Aaron

On Fri, Apr 09, 2004 at 04:03:32PM +1000, Benjamin Herrenschmidt wrote:
>
> On Thu, 2004-04-08 at 23:14, Aaron Lunansky wrote:
> > So what I've figured out so far is that the system is not crashed- the
> > screen is still on in fact, blinking a cursor in the top left. I can ssh
> > in to the machine but a cursory review of dmesg shows nothing of
> > significance.
> >
> > Unfortunately I can't do much with an ssh session before it seems to lock up,
> > but I can launch another ssh session if I want. Also, if I disconnect my
> > USB keyboard while the screen is in this blinking state, I get a "USB
> > device soandso" disconnected message.
> >
> > Since my machines not crashing I can poke at it some more, but I could
> > use some pointers as to where I should poke.
>
> You didn't reply to my questions.
>
> > Thanks,
> > Aaron
> >
> > On Thu, Apr 08, 2004 at 08:49:31AM +1000, Benjamin Herrenschmidt wrote:
> > > On Thu, 2004-04-08 at 05:17, Aaron Lunansky wrote:
> > > > I'm having similar issues with an ibook G3 (600MHz) - only my system
> > > > seems to fail to sleep, and this is regardless of modules (I have
> > > > sound/airport/ethernet compiled as modules). By fails to sleep, I mean I
> > > > get a blank screen and it does not respond to any input. I'm not sure
> > > > where it is when it dies though - what's the best way to figure this
> > > > out? (how can I make SysRq work on an ibook (which has no SysRq key)).
> > >
> > > No, once the screen is off, there isn't much you can do. I suggest
> > > you do some experiments in console mode, use "snooze -f" (that will
> > > bypass pmud or pbbuttonsd, which tend to cut the backlight early).
> > >
> > > Also, did it die on sleep or on wakeup ? That is, did it reach the
> > > sleep state where the led starts "snoring" ?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
