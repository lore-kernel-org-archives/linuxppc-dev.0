Date: Fri, 7 Mar 2003 13:23:35 -0600
From: Nathan Ingersoll <ningerso@ruralcenter.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Runtime Altivec detection
Message-ID: <20030307192335.GB7169@ruralcenter.org>
References: <20030307164753.GA5240@ruralcenter.org> <20030307185458.7bb979cb.damm@opensource.se> <20030307180802.GB6252@ruralcenter.org> <20030307194445.270e7dfc.damm@opensource.se>
Mime-Version: 1.0
In-Reply-To: <20030307194445.270e7dfc.damm@opensource.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 07, 2003 at 07:44:45PM +0000, Magnus Damm wrote:
>
> The latest released mplayer requires you to pass --enable-altivec to
> configure. A runtime check is then performed in: mplayer/cpudetect.c
> and ffmpeg/libavcodec/ppc/dsputil_altivec.c

Ok, that's pretty funny actually. Now that I've looked at that code, it
appears they use the same method I do. Slightly different code, but they
are writing it for an app, not a library. Strange that I wasn't able to
find this at all through google.

> Sorry, I think I was a little bit unclear in my question, Do you have
> to pass any specific flags to gcc to be able to complile altivec code,
> and if these flags are "-maltivec -mabi=altivec", is it possible to
> pass them to gcc and still compile for G3 (-mcpu=750)?
>
> It's a nice feature to be able to build one binary that is optimized
> for G3 but does runtime checks and enables altivec if present.

Those are probably incompatible flags, since you are telling it to
target a specific cpu, but also telling it to use features not present
in that cpu model.

--
------------------------------------------------------------------------
| Nathan Ingersoll           \\ Computer Systems & Network Coordinator |
| ningerso@ruralcenter.org    \\ http://www.ruralcenter.org            |
| http://ningerso.atmos.org/   \\ Minnesota Center for Rural Health    |
------------------------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
