Date: Wed, 28 Nov 2001 16:06:15 -0900
From: Ethan Benson <erbenson@alaska.net>
To: Joseph Manojlovich <manojlov@cse.psu.edu>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 'make rpm' Failing due to i386 bug
Message-ID: <20011128160615.I10071@plato.local.lan>
References: <20011127233224.C23109@cardassian.cse.psu.edu> <20011128104926.C28956@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
In-Reply-To: <20011128104926.C28956@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Wed, Nov 28, 2001 at 10:49:26AM -0700
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 28, 2001 at 10:49:26AM -0700, Tom Rini wrote:
>
> On Tue, Nov 27, 2001 at 11:32:24PM -0500, Joseph Manojlovich wrote:
>
> > Hey all. I was using the latest stable branch from source.mvista.com,
> > and noticed that 'make rpm' wasn't working. Looking closer, I noticed
> > that a supporting script, scripts/mkspec, is quite 386 specific. It
> > makes an rpm spec file that assumes the kernel image is compressed,
> > which with ppc it isn't (for me at least).
>
> You could try %ifarch ppc ... %else .. %endif.  Tho we do have a
> 'bzImage' target, and yaboot might even do the 'zimages' on pmac as well
> as chrp now.  Talk to Alan Cox since this is his script anyhow.

no we have a zImage target, not bzImage which is a i386 specific hack
to work around that braindamaged architecture.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
