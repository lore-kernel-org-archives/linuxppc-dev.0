Date: Fri, 9 Jul 2004 10:26:45 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: what's the value of CONFIG_8xx_UART?
Message-ID: <20040709172645.GE28002@smtp.west.cox.net>
References: <Pine.LNX.4.60.0407081800340.1772@localhost.localdomain> <20040709160919.GD28002@smtp.west.cox.net> <Pine.LNX.4.60.0407091316110.3143@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0407091316110.3143@localhost.localdomain>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jul 09, 2004 at 01:18:02PM -0400, Robert P. J. Day wrote:

> p.s.  when you say "should be in kernel.org soon", what's the flow of
> fixes between that and the linuxppc-2.5 tree at bkbits?

Once a change makes it into Linus' tree, it can be pulled into
linuxppc-2.5.  If there's a known important fix like this, it'll
get pulled back into linuxppc-2.5 sooner, rather than later.  But it is
a manual process.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
