Subject: Re: linuxppc-2.5 fixlets
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Berndtsson <stefan@nocrew.org>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <87wud5vs3r.fsf@hades.nocrew.org>
References: <1061487408.1862.10.camel@thor.holligenstrasse29.lan>
	 <1061496837.18043.1.camel@gaston>  <87wud5vs3r.fsf@hades.nocrew.org>
Content-Type: text/plain
Message-Id: <1061553526.812.14.camel@gaston>
Mime-Version: 1.0
Date: Fri, 22 Aug 2003 13:58:46 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2003-08-22 at 13:39, Stefan Berndtsson wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>
> > I'm preparing a new set of patches that include all my driver
> > changes except the video ones. I'll send those ones separately to
> > James first as they rely on some fbdev infrastructure changes.
>
> Does this set contain any audio fixes (either alsa or dmasound) for
> the tumbler (ibook2 - late 2001)?
>
> Alsa does not seem to produce any sound, whatever I try to do (including
> messing around with mute), and dmasound doesn't compile at all.
>
> Used kernel is 2.6.0-test3, via rsync from source.mvista.com::linuxppc-2.5,
> as of around 10AM CET (8AM UTC).

No, though I don't do the Alsa stuff (note that I'm also deprecating
dmasound). Regarding Alsa, did you try alsamixer ? I noticed that Alsa
own "Mute" property appear to not be reflected to the /dev/mixer OSS
emulation properly

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
