Message-ID: <3B3C3AF3.4DD7DB6F@mvista.com>
Date: Fri, 29 Jun 2001 04:23:15 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Kevin Fry <kevin@carts.com>
Cc: 1337 linuxppc list ???? <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: invalid page faults..
References: <3B3A5A16.6010005@ccc-dcs.com> <3B3A7958.340746FC@carts.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kevin Fry wrote:

> What happens is that load_elf_interp() is called and then it calls
> padzero(elf_bss) and the page faults start occuring.
> when padzero is called elf_bss is in the 3Exxxxx range. Why would it be so
> high in memory?

It's a virtual address.  You are going to see lots of page faults when
a program starts up.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
