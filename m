Message-ID: <3AE47999.A0589002@mvista.com>
Date: Mon, 23 Apr 2001 14:51:05 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: alex daniloff <alex_daniloff@mail.ru>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Qspan driver
References: <E14rbTK-000PMz-00@f5.mail.ru>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


alex daniloff wrote:
>
> I'm looking for embedded driver for Qspan.

There are a couple of different implementations of the Tundra
Qspan for MPC8xx in the Linux sources.  You may have to adapt
them depending upon your design, as there are many possibilities.

> I've found only drivers for host or pc not for embedded OS.

Well, these aren't really "drivers", but rather the bridge
initialization and configuration space I/O functions.

> I tried to read from PMC PCI configuration space but I've got Machine Check.

Even for a properly configured Qspan you will get these for devices
that don't exist.  You need to ensure (as Linux does) that you have
a continuation model machine check handler that can return errors to
the caller of this type of access.




	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
