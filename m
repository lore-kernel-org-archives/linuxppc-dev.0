Date: Thu, 20 Sep 2001 09:12:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Salisbury <mbs@mc.com>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ppc LE questions (seeking help hand info pointers)
Message-ID: <20010920091221.H13721@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010920085825.F13721@cpe-24-221-152-185.az.sprintbbd.net> <Pine.GSO.4.21.0109201807150.14835-100000@mullein.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.21.0109201807150.14835-100000@mullein.sonytel.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Sep 20, 2001 at 06:07:48PM +0200, Geert Uytterhoeven wrote:
> On Thu, 20 Sep 2001, Tom Rini wrote:
> > On Thu, Sep 20, 2001 at 11:42:39AM -0400, Mark Salisbury wrote:
> > > question 4. assuming I was willing to deliver a clean, complete LE
> > > enabling patch (including devices that are relevant to me), as a compile
> > > time config option and maintain that patch, what would be the primary
> > > obstacle to inclusion in the main line.
> >
> > The objection to being an arch that attempts to support both LE and BE.
>
> Note that we already have a precedent: mips and mipsel, both in arch/mips/.

And SH too, iirc.  I know it can be done.  But do we want to do it is the
question.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
