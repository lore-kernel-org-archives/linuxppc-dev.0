Message-ID: <3A2289DE.D96A45DA@mvista.com>
Date: Mon, 27 Nov 2000 11:20:46 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Kwansuk Kim <kskim@neowave.co.kr>
CC: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Using request_8xxirq
References: <NEBBKFENMLEDKDHMEHPJAEOCCBAA.kskim@neowave.co.kr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kwansuk Kim wrote:

> "#define request_irq request_8xxirq"

Bad, bad, bad.....

> I wonder whether request_8xxirq can work same as request_irq, and all modules work with request_8xxirq.

It does not work the same, which is why there is a different function
with a different name.  The drivers that use the request_irq function
assume PC 8259 type interrupt numbers, which is completely inappropriate
for the internal 8xx interrupt controller.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
