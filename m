Date: Tue, 27 May 2003 13:13:43 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: Jean-Denis Boyer <jdboyer@m5t.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: PATCH: arch/ppc/8xx_io_fec.c
Message-ID: <20030527201343.GM3453@ip68-0-152-218.tc.ph.cox.net>
References: <AB5AF73EAF23304EA1B932174137CED702FB6D@m5tmail.m5t.com> <20030527165824.GG3453@ip68-0-152-218.tc.ph.cox.net> <3ED3BDA0.3030208@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3ED3BDA0.3030208@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, May 27, 2003 at 03:33:52PM -0400, Dan Malek wrote:

> Tom Rini wrote:
>
> >Dan, do you see any problems with this?
>
> Yes.  There are silicon revisions that require the FEC to
> be enabled for the MDIO to operate.  I don't remember if it was
> listed in errata or in some of the early supplements.  This code
> change may work in this particular case, but I know it's required
> for some parts.  I have not looked at the detail of the patch
> and the code it moves to see if this is done elsewhere.

How would you suggest working around both this problem, and the problems
that Jean-Denis reported?  Having either be broken for the sake of the
other can't be acceptiable, can it? :)

> The code formatting looks like crap, so that needs to be fixed.

That's trivial 'tho. :)

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
