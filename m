Date: Fri, 30 Jul 2004 09:50:26 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Leigh Brown <leigh@solinno.co.uk>, paulus@samba.org,
	linuxppc-dev@lists.linuxppc.org, barbieri@gmail.com
Subject: Re: [0/9] Support for old IBM PReP boxes
Message-ID: <20040730165026.GN16468@smtp.west.cox.net>
References: <20040729213319.GA5857@george.solinno.co.uk> <20040730154611.GL16468@smtp.west.cox.net> <20040730160848.GA12973@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040730160848.GA12973@lst.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jul 30, 2004 at 06:08:48PM +0200, Christoph Hellwig wrote:

> On Fri, Jul 30, 2004 at 08:46:11AM -0700, Tom Rini wrote:
> > OK.  Thinking back to last time, I asked about being able to blacklist
> > some machines Residual Data (since it's crap on some, but I don't have
> > the dumps handy) and you mentioned that you'd like to do fixups on the
> > data since there's a few cases where the data is mostly good, just with
> > one or two incorrect things.  And it doesn't look like either are
> > here... yet.
> >
> > Could you do a 10/9 patch that adds a bit of help to the PREP_RESIDUAL
> > config option along the lines of:
> > "When this information is incorrect, it could lead to the machine
> > behaving incorrectly.  If this happens, please disable PREP_RESIDUAL and
> > try again."
> >
> > And change the existing "Unless you expect to boot on a PReP system,
> > there is no need to select Y." to "If you are running a PReP system, say
> > Y here, otherwise say N."
>
> As the residual support is runtime switchable can we also have a kernel
> boot option?  That way we can switch it off for distro kernels.

A distro kernel would probably want it on by default (it makes more
machines work than it breaks).  As for runtime switchable, Leigh?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
