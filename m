Date: Thu, 9 Jan 2003 00:30:21 -0800
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Boris Bezlaj <boris@bandit.kista.gajba.net>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Status of linuxppc_2.5
Message-ID: <20030109083021.GA16190@pants.nu>
References: <3E1BECD2.9060909@intracom.gr> <20030108173215.GA1002@bandit.kista.gajba.net> <1042049915.787.9.camel@zion.wanadoo.fr> <3E1D2F34.20908@intracom.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E1D2F34.20908@intracom.gr>
From: flar@pants.nu (Brad Boyer)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 09, 2003 at 10:13:40AM +0200, Pantelis Antoniou wrote:
> I'm sorry, the patch is just trivial stuff needed
> to get it to compile. I don't even have hardware
> that applies to swim3 driver. I just added the
> include for the header and modified the call
> to ide_unregister to use the new calling convention.
>
> BTW ide_unregister was not exported in linux/ide.h
> and so I added the prototype there. Maybe someone
> should notify the maintainer of the IDE layer that
> since this function is needed by the swim3 driver
> it should be visible in the header?
> Or we should use a new infrastructure?

Is there a reason that the swim3 driver needs something
from the IDE layer? I haven't tried 2.5 on my 7600 yet,
but when I'm compiling a kernel for it, I never include
IDE, since the motherboard doesn't have IDE hardware.
Any machine old enough to use the swim3 driver is slow
enough without any help...

	Brad Boyer
	flar@allandria.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
