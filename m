Date: Sat, 10 Nov 2001 19:58:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: APUS irq patch
Message-ID: <20011110195803.C573@cpe-24-221-152-185.az.sprintbbd.net>
References: <Pine.LNX.4.33.0111102221430.12896-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.33.0111102221430.12896-100000@serv>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Nov 10, 2001 at 11:10:25PM +0100, Roman Zippel wrote:

> Here is a new patch to update APUS irq handling.
> First, it moves the assembly part in head.S to apus_get_irq, which uses a
> local table instead of the stack now to save some additional irq context.
> Second, the major change of this patch is to convert APUS to use the
> general irq management code.

Looks good, applied.  In the future can you please make the patches vs
_devel?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
