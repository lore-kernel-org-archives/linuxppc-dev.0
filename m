Message-ID: <3BA61D1A.3A79E5B9@mvista.com>
Date: Mon, 17 Sep 2001 11:56:10 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org,
	David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Board names for 4xx
References: <20010914144403.G3851@zax> <20010914072847.R21906@cpe-24-221-152-185.az.sprintbbd.net> <20010917122828.J3851@zax> <20010916211605.D14279@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> I do wish someone else would speak up tho.  Does anyone out there have an
> opinion?

It depends how you want to use this information.  In the kernel, it is very
critical we clearly distinguish between the "core" (the thing that executes
instructions), the peripherals (the real difference among the SOC-type
processors), and the board design (which will determine how the peripherals
are configured).

If the information from /proc is just used for pretty print out of
information, I really don't care.  If there are applications that read
this for some internal configuration and flexibility, we better have a
standard format.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
