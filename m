Date: Tue, 21 May 2002 10:27:19 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Armin Kuster <akuster@mvista.com>
Cc: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>,
	Linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>,
	andrew may <acmay@acmay.homeip.net>
Subject: Re: 405 I2C
Message-ID: <20020521102719.A20012@ecam.san.rr.com>
References: <1021995053.7265.22.camel@swb11> <3CEA70AB.1070405@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CEA70AB.1070405@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, May 21, 2002 at 09:07:07AM -0700, Armin Kuster wrote:
> They should both work as modules as it stands, or at least it did in the
> past.  IMHO is does not matter if it is one or two files. Andrew's
> iic_xfer was bundled in with many other changes that did not fly, but I
> would revisit is if a new patch where submitted with just the iic_xfer.

What changes didn't fly? I only know of the one for the clock divider.
I posted it May 7 and heard nothing in the way of comments. I then got
no warning that the source was going to be linted and completely invalidate
the usefullness of the patch.

http://lists.linuxppc.org/linuxppc-embedded/200205/msg00070.html
http://lists.linuxppc.org/linuxppc-embedded/200205/msg00060.html

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
