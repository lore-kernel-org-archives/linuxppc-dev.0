Date: Tue, 28 May 2002 11:43:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rajappa Iyer <rsi@panix.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: P2P bridge (DEC 21154) initialization on MCP750
Message-ID: <20020528184332.GK1295@opus.bloom.county>
References: <200205250114.g4P1ELi08721@panix1.panix.com> <20020524200953.A21781@home.com> <200205272214.g4RMEOP02787@panix3.panix.com> <20020527164626.A1740@home.com> <200205281835.g4SIZKf09966@panix3.panix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200205281835.g4SIZKf09966@panix3.panix.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, May 28, 2002 at 02:35:20PM -0400, Rajappa Iyer wrote:
>
> Matt Porter <porter@cox.net> writes:
>
> > On Mon, May 27, 2002 at 06:14:24PM -0400, Rajappa Iyer wrote:
>
> > > Thanks.  This did improve the situation somewhat in that the P2P
> > > bridge is now initialized properly, but the devices beyond it are
> > > still not probed.   Incidentally, I had to work with 2.5.x, since the
> > > 2.4 devel kernel was, for some reason, unbearably slow.
>
> > You're the first person to try one of these boards on 2.5 that I've
> > heard of.  Can you explain what you mean by "unbearably slow" on
> > _devel?  Please enable DEBUG in arch/ppc/kernel/pci.c and
> > drivers/pci/pci.c and repost those kernel messages.
>
> Sure, here it is.
>
> What I mean by unbearably slow is that once init starts running, the
> system just slows down to a complete crawl.  It takes about 2 minutes
> for the login prompt to appear.  To run lspci -v took about 10 minutes
> (I'm not exaggerating.)

Oh, yes.  The OpenPIC_InitSenses needs to be updated.  Look at
arch/ppc/platforms/lopec_setup.c

Patches appreciated.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
