Date: Sat, 12 Jul 2003 20:15:57 +0200
From: Boris Bezlaj <boris@gajba.net>
To: Jasper Spaans <jasper@vs19.net>
Cc: paulus@samba.org, benh@kernel.crashing.org,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: cleanup of linux-2.5/drivers/block/swim3.c
Message-ID: <20030712181557.GA3520@gajba.net>
References: <20030704104616.GA29229@spaans.vs19.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030704104616.GA29229@spaans.vs19.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jul 04, 2003 at 12:46:16PM +0200, Jasper Spaans wrote:
> Hello,
>
> Attached is a patch which should solve compilation issues related to the new
> irqhandler interface, and the deprecation of cli()/sti() for the
> swim3-driver.
>
> Can you take a look, and possibly, apply this? (I don't have any hardware to
> test this on, however it compiles)

You did not take into account the changes made to swim3 driver in 2.4
kernel (fixing write operation) made by Paul.

I will try to merge the two and update BIO stuff. I'm not so sure about
the new macio device interface..should be fun :)

--

		Boris


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
