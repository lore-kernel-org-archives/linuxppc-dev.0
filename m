Date: Fri, 2 Nov 2001 10:59:00 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: APUS irq patch
In-Reply-To: <20011101175703.A26802@cpe-24-221-152-185.az.sprintbbd.net>
Message-ID: <Pine.LNX.4.33.0111021055210.11002-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Thu, 1 Nov 2001, Tom Rini wrote:

> Well, could we accomidate APUS with some PPC-specific changes that don't
> touch generic stuffs?

Hmm, only by adding the call to apus_end_irq directly to the interrupt
routine (within an #ifdef CONFIG_APUS).

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
