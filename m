Date: Fri, 11 Jun 2004 14:40:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Stephen Williams <612dlag102@sneakemail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Head of linuxppc-2.4 broekn by davem patch
Message-ID: <20040611214054.GB925@smtp.west.cox.net>
References: <1086934906.4820.2.camel@lucy.pep-kaufbeuren.de> <29963-82182@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <29963-82182@sneakemail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jun 11, 2004 at 09:07:13AM -0700, Stephen Williams wrote:

> Stefan Nickl Stefan.Nickl-at-kontron.com |PPC Linux Embedded| wrote:
> >I already sent this patch to the list and to "davem" who
> >commited the faulty version, but nobody seems to care...
>
> Here is the exact same patch, packaged slightly differently
> and re-sent, just in case it got lost in someone's inbox.
> It is also possible that davem is thinking in terms of
> changing the sk_buff definition t match this file. Either
> way, something must be done.

I've gotten around to updating the linuxppc-2.4 repository to match the
current state of linux-2.4 again.  If there's still a problem, I would
suggest reproducing it with an i386 config (or CONFIG_ALL_PPC config)
and posting to lkml (linux-kernel@vger.kernel.org) and cc'ing Marcelo
and whomever made the broken change.  The problem in question didn't
come from us PPC folks, so fixing it in our tree is, IMHO, pointless
(the fix will either become obsolete and introduce minor pain when a fix
comes in upstream or the change will be reverted, again probably causing
us pain merging this in).

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
