Message-ID: <39EFABFF.96F35223@mvista.com>
Date: Thu, 19 Oct 2000 22:20:47 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Tomas Carmen <tomas@tcc.com.pe>
CC: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kernel for 823 over 16bits
References: <39EF85BB.FA712976@tcc.com.pe>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tomas Carmen wrote:

> I would like to know if the linux kernel or the bootloader developed for
> PPC (MPC8xx) can working well
> over a 16 bits environment (FLASH and RAM).

You mean you are just using a 16-bit data bus?  Kind of weird, but
the software doesn't care.  Make sure you run with caches on and
make sure you are careful of multiword cycles when accessing I/O
in 32-bit operations.


	-- Dan

--

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
