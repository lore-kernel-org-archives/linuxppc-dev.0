Message-ID: <3E9182F4.5020704@embeddededge.com>
Date: Mon, 07 Apr 2003 09:53:56 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: tglx@linutronix.de
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: check MMU state
References: <200304051735.25831.tglx@linutronix.de> <1049556246.654.7.camel@zion.wanadoo.fr> <3E8F2101.3090103@embeddededge.com> <200304060413.33628.tglx@linutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thomas Gleixner wrote:

> I'm working on a PMC board, where I can't modify the bootloader for now.

One of us doesn't understand the other :-)

The 'piggyback' loaders are in arch/ppc/boot.  These are wrappers around
a compressed kernel.  Their purpose is to take a boot environment, that
you likely can't modify, and convert it to something suitable for linux
before uncompressing/booting the kernel.

> I had to fight some time, but finaly i got it to work. :)

I don't understand how.  The 8xx has internal boot parameters that must
get initialized by a piggyback loader.  How did you do that?

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
