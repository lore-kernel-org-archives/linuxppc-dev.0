Date: Fri, 2 Nov 2001 09:03:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: APUS irq patch
Message-ID: <20011102090302.D26147@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011101175703.A26802@cpe-24-221-152-185.az.sprintbbd.net> <Pine.LNX.4.33.0111021055210.11002-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.33.0111021055210.11002-100000@serv>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Nov 02, 2001 at 10:59:00AM +0100, Roman Zippel wrote:
> Hi,
>
> On Thu, 1 Nov 2001, Tom Rini wrote:
>
> > Well, could we accomidate APUS with some PPC-specific changes that don't
> > touch generic stuffs?
>
> Hmm, only by adding the call to apus_end_irq directly to the interrupt
> routine (within an #ifdef CONFIG_APUS).

IMHO, that's a better solution for 2.4.  I'm assuming the end goal of
all of this merging is to get APUS working in kernel.org, right? :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
