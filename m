Date: Thu, 27 Sep 2001 13:33:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@mvista.com>
Cc: "Williams, Kevin M." <kevin.m.williams@marconi.com>,
	embarque ppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: minor commproc.h fix
Message-ID: <20010927133302.A23005@cpe-24-221-152-185.az.sprintbbd.net>
References: <A3E34B558F5CD211B4980008C7A4A99003C58441@sparrow.eng.gilbarco.com> <3BB3890B.FE7E6FEE@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BB3890B.FE7E6FEE@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 27, 2001 at 04:16:11PM -0400, Dan Malek wrote:
> "Williams, Kevin M." wrote:
> >
> > Can you please make the following change to the linuxppc_2_4 tree:
>
> Well, this is odd....it's correct in the _devel tree......
>
> I don't use the 2_4 tree, so if someone could verify and fix
> this (Tom? :-).

2_4 is a bit out of date, wrt 8xx.  I'm trying to work on it really :)
Wolfgang probably noticed this and it was part of one of his patches..

> > 3 is odd parity, 2 is even. See page 22-14 of the MPC850 user's manual.
>
> Actually 0 is odd parity, 2 is even.  The code will either set or
> clear this bit depending upon the serial port settings requested.

The comments/names are wierd, We do either EVP (even parity) or marked partiy
i think it's called.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
