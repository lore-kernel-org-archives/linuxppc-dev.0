Date: Mon, 11 Oct 1999 20:10:49 -0700 (MST)
From: Tom Rini <trini@kernel.crashing.org>
To: Ryan Nielsen <ran@krazynet.com>
cc: Eric Dorland <dorland@lords.com>, Elliot Lee <sopwith@redhat.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: esound for PPC
In-Reply-To: <19991011200346.A258@gondolin.asf>
Message-ID: <Pine.LNX.4.10.9910112010030.15511-100000@opus.bloom.county>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 11 Oct 1999, Ryan Nielsen wrote:

> Tom Rini wrote:
> > 
> > On Mon, 11 Oct 1999, Eric Dorland wrote:
> > 
> > > It appears I spoke to soon about sound working perfectly. Whenever esd plays
> > > a 16bit wav file, the sound plays at about half speed. Ugg. At least its not
> > > static anymore. I'm going to see if I can track down why this is happening
> > > (maybe its some on-the-fly endianess swaping slowing it down), but I don't
> > > know sound code all that well, so anyone that does, please lend a hand.
> > 
> > Elliot has the old set of patches ported up to 0.2.15, and hopefully will
> > be in 0.2.16 :)
> 
> Does this fix the problem Eric wrote about ?
> Þere is a bug in dmasound.c that causes sound to be played at 22050 Hz
> instead of (usually) 44100 Hz if a beep (from awacs_mksound) is played.

It only fixed problems that're really esound's fault (ie the static
stuff).  Whats broken in 0.2.14 is still broken (and dmasound is crap
anyhow :))

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
