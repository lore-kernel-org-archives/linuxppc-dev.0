Date: Fri, 9 Apr 2004 21:20:23 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: [resolved] Re: 2.6.5/iBook G3: Oops on resume from sleep
Message-ID: <20040410012023.GA7393@csclub.uwaterloo.ca>
References: <20040405215318.GA2822@mortadelo.pirispons.net> <20040407191719.GA4852@csclub.uwaterloo.ca> <1081378171.1380.68.camel@gaston> <20040408131404.GA28251@csclub.uwaterloo.ca> <1081490612.1382.125.camel@gaston> <20040409134748.GA11157@csclub.uwaterloo.ca> <1081554759.25144.155.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1081554759.25144.155.camel@gaston>
From: muffin@csclub.uwaterloo.ca (Aaron Lunansky)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


heh, good call, it was pmac_zilog that was causing the weird behaviour.
Removed it from my kernel (it was compiled in) and my system sleeps fine now.

Thanks,
Aaron

On Sat, Apr 10, 2004 at 09:52:40AM +1000, Benjamin Herrenschmidt wrote:
>
> On Fri, 2004-04-09 at 23:47, Aaron Lunansky wrote:
> > What I was saying is the system doesn't seem to crash, but ends up in a bad state.
> > The system doesn't make it to sleep (the led does not 'snore').
> >
> > Did I miss anything?
>
> Ah ok, that's what I wanted to know. I tdid _not_ snore.
>
> At this point, I don't know what's up. Make sure you don't have a
> broken driver (like Alsa). Eventually remove pmac_zilog too (it
> should work but then, I did hear about problems with earlier versions)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
