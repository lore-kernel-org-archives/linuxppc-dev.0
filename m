Date: Tue, 9 Jan 2001 23:39:18 +0100 (MET)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: Linux PPC Developer Mailing List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: status of ppc support in official 2.4.0 or Alan's 2.4.0-ac1
In-Reply-To: <20010108154728.27D541BFDC@atlas.valhalla.net>
Message-ID: <Pine.SOL.3.95.1010109232901.18965C-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 8 Jan 2001, Iain Sandoe wrote:

> Hi Derek,
>
> Mon, Jan 8, 2001, Derek Homeier wrote:
>
> [...] re 2.4.0 tree at ppc.samba,org (I think ;-).
>
> > I have some problems with dmasound and ppp modules, though. After some
> > fiddling with modules.conf I was able to get the mixer (from gkrellm)
> > to work and sound from internal and external speakers by aliasing
> > char-major-13 to dmasound_awacs, but there are occasional messages about
> > several sound-slot-[01] and sound-services-[01]-[013](?) modules
> > missing. The mixer tends to hang and has to be killed then. While
> > mpg123 did work, xmms always crashes with a Bus error on startup.
>
> Hmm.  I built ppc.samba.org::linux-pmac-devel the other day (in response to
> another query) and the dmasound module appeared to be fine.
>
> Those messages relate to OSS (or even ALSA support, don't know without
> checking) - and don't originate from the dmasound code.  Possibly there are
> still facilities (like the DSP_GETCAPS type) that are not completely
> implemented (or still not implemented at all).  I'll look when I get back to
> it - or someone else can ;-).
>
> For now, I suggest that (unless you desperately need it), - you disable the
> OSS stuff in your .config.
>

O.K., did that (I did not have ALSA enabled in the first place), and didn't
see the errors again. Nonetheless, xmms is still erring on the Bus
(i.e. crashes as soon it is started).

Cheers,
							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
