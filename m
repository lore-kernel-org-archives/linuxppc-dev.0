Date: Sun, 12 Oct 2003 13:10:14 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jens Schmalzing <jens.schmalzing@physik.uni-muenchen.de>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Need a Linux PPC kernel which supports the Radeon Mobility 9600
Message-ID: <20031012111014.GB1677@mars.ravnborg.org>
References: <A6E33C4E-FB6C-11D7-9C03-000393467F1A@arlut.utexas.edu> <1065823660.601.0.camel@gaston> <hhk77bv495.fsf@pygar.theorie.physik.uni-muenchen.de> <1065953260.992.11.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1065953260.992.11.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Oct 12, 2003 at 12:07:41PM +0200, Benjamin Herrenschmidt wrote:
>
> On Sat, 2003-10-11 at 23:44, Jens Schmalzing wrote:
> > Hi,
> >
> > Benjamin Herrenschmidt writes:
> >
> > > I just fixed that in my 2.6 and I'll backport to 2.4 soon
> >
> > I compiled the latest version of that tree in order to get radeonfb
> > working on my 17" Powerbook.  A few questions:
> >
> > 1. The resulting kernel is more than 30MB in size.  Is this normal?

Check that CONFIG_DEBUG_INFO is unset.
Otherwise the kernel will be much bigger - due to the symbolic info.

	Sam

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
