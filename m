Date: Wed, 21 Nov 2001 13:51:17 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Simon Winwood <sjw@cse.unsw.edu.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Walnut boottime issues
Message-ID: <20011121135117.N3436@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011121104517.A12111@cse.unsw.edu.au> <20011120173502.D821@cpe-24-221-152-185.az.sprintbbd.net> <20011122054437.A26819@cse.unsw.edu.au> <20011121115344.H3436@cpe-24-221-152-185.az.sprintbbd.net> <20011122070413.C26819@cse.unsw.edu.au> <20011121132339.K3436@cpe-24-221-152-185.az.sprintbbd.net> <20011122073805.A26682@cse.unsw.edu.au> <20011121134039.M3436@cpe-24-221-152-185.az.sprintbbd.net> <20011122074525.B26682@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011122074525.B26682@cse.unsw.edu.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Nov 22, 2001 at 07:45:25AM +1100, Simon Winwood wrote:

> 	Well, I can't boot at all with the bootloader stuff removed, but
> this is a reasonably old bug --- I got it occasionally when I was using
> the kernel about a month ago.
>
> 	The oops happens as soon as the kernel tries to exec init (in this
> case its /bin/sash).  It happens every time I try to boot (as opposed to
> sporadically like before)

Okay.  What userland/toolchain are you using, and did you turn on
CONFIG_MATH_EMULATION or no?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
