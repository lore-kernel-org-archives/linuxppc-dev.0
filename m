Date: Fri, 7 Mar 2003 19:44:45 +0000
From: Magnus Damm <damm@opensource.se>
To: Nathan Ingersoll <ningerso@ruralcenter.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Runtime Altivec detection
Message-Id: <20030307194445.270e7dfc.damm@opensource.se>
In-Reply-To: <20030307180802.GB6252@ruralcenter.org>
References: <20030307164753.GA5240@ruralcenter.org>
	<20030307185458.7bb979cb.damm@opensource.se>
	<20030307180802.GB6252@ruralcenter.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 7 Mar 2003 12:08:02 -0600
Nathan Ingersoll <ningerso@ruralcenter.org> wrote:
> > mplayer and ffmpeg does some kind of detection runtime.
> > I'm playing with it right now actually.
>
> Last I heard, it was a compile time detection or flag. So you had to build
> separate binaries for your G4 and non-G4 machines.

The latest released mplayer requires you to pass --enable-altivec to configure.
A runtime check is then performed in:
mplayer/cpudetect.c and ffmpeg/libavcodec/ppc/dsputil_altivec.c

> > I've seen that -maltivec and -mabi=altivec is passed sometimes.
> > If I want to build a binary that should be able to run on a
> > G3 without altivec and utilize altivec when present on a G4,
> > what flags should I use?
>
> There is no specific flag for doing so, you need some code to detect the
> capability, and then decide whether to use the Altivec routine.

Sorry, I think I was a little bit unclear in my question,
Do you have to pass any specific flags to gcc to be able to complile
altivec code, and if these flags are "-maltivec -mabi=altivec", is
it possible to pass them to gcc and still compile for G3 (-mcpu=750)?

It's a nice feature to be able to build one binary that is optimized
for G3 but does runtime checks and enables altivec if present.

/ magnus

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
