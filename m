Date: Sun, 16 Sep 2001 21:16:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-embedded@lists.linuxppc.org
Cc: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Board names for 4xx
Message-ID: <20010916211605.D14279@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010914144403.G3851@zax> <20010914072847.R21906@cpe-24-221-152-185.az.sprintbbd.net> <20010917122828.J3851@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010917122828.J3851@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Sep 17, 2001 at 12:28:28PM +1000, David Gibson wrote:

> On Fri, Sep 14, 2001 at 07:28:47AM -0700, Tom Rini wrote:
[snip]
> > machine:\t\t<Core>: <Board>
> > ie:
> > 405GP: IBM Walnut
> > 405GP: EmbeddedPlanet
> > or
> > 403CX: TiVo
>
> I don't see why - this information already appears in the "cpu:"
> field and on machines that do have the "machine:" field it doesn't
> generally include processor type information.

Well, because they usually (at least what I can think of, but I haven't
been on the userland side of things for a while) don't bother with
the cpu field.  Hence I was thinking of being able to case based on
'405GP'* instead of per-board.  Thats just my 2cents tho, take it for what
you will.

I do wish someone else would speak up tho.  Does anyone out there have an
opinion?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
