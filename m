Date: Wed, 31 Mar 2004 11:18:19 +0200 (CEST)
From: Christiaan Welvaart <cjw@daneel.dyndns.org>
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: iBook G3: status of 2.6.5
In-Reply-To: <1080690668.1216.65.camel@gaston>
Message-ID: <Pine.LNX.4.58.0403311105030.19002@zem.cjw.nep>
References: <c4c2si$dv7$1@sea.gmane.org>  <1080687801.13152.56.camel@gaston>
  <1080689835.9195.52.camel@thor.asgaard.local> <1080690668.1216.65.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 31 Mar 2004, Benjamin Herrenschmidt wrote:

> On Wed, 2004-03-31 at 09:37, Michel Dänzer wrote:
> > On Wed, 2004-03-31 at 01:03, Benjamin Herrenschmidt wrote:
> > >
> > > > Is there a working ALSA driver or I have to use the OSS one?
> > >
> > > I'm not sure how well the Alsa driver will work, it works pretty badly
> > > for me on the tipb 1Ghz, though the dmasound (oss) one works fine.
> >
> > ALSA works better than dmasound on the same machine here... must be a
> > configuration issue on your end. :)
>
> Really weird. I talked to the xine maintainer, and it really seems
> like the "clacs" I hear duing DVD playback are caused by the Alsa
> driver (though it does acheive better lip sync), while dmasound
> has proper sound quality, but incorrect sync...

on a beige G3:
With a 2.6.3-based kernel, PREEMPT on (no idea if that matters), I hear
occasional glitches in the sound output, using xmms. It sounds like it's
playing some random piece of data in memory for maybe 0.2s. How often this
happens seems to be independent of system load. The alsa driver works fine
in 2.4, and IIRC also with 2.6.0 (without PREEMPT).


    Christiaan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
