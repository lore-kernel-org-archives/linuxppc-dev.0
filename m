To: Dan Malek <dan@embeddededge.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Kumar Gala <kumar.gala@motorola.com>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mpc5xxx support (Was: Re: Proposed Kconfig update patch for help text) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 01 Apr 2004 11:58:14 CDT."
             <406C4A26.3040107@embeddededge.com>
Date: Thu, 01 Apr 2004 19:18:22 +0200
Message-Id: <20040401171827.57899C10A4@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <406C4A26.3040107@embeddededge.com> you wrote:
>
> > In all seriousness, when the 52xx code for 2.4 was brought up, there
> > were a number of objections to the Motorola provided code,
>
> Does anyone actually use this code?  From the work I've done it appears

Yes.

> the FEC implements it's own DMA, other peripherals are used in programmed I/O

Indeed, the FEC implementation should be cleaned up.

> mode, and stuff I have done I've found it easier to just write my own
> code manage the DMA.  IMHO we should just punt this stuff for Linux,
> now that there is more public interest start collaborating on a better
> solution, and maybe just use what Mot provided as documentation filler.

I cannot speak for Motorola, but I understand they would welcome  any
input for improvement. Instead of working separately and against each
other we should co-operate.

> The Motorola solution seems like an attempt to be everything for everyone.

Indeed. They have to support more than just Linux.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
As usual, this being a 1.3.x release, I haven't  even  compiled  this
kernel yet. So if it works, you should be doubly impressed.
      - Linus Torvalds in <199506181536.SAA10638@keos.cs.Helsinki.FI>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
