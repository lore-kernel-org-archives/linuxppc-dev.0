Message-ID: <3A92AF20.B5358872@mvista.com>
Date: Tue, 20 Feb 2001 12:53:36 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Paolo Marini <paolom@prisma-eng.it>
Cc: Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Linux on PPC 855
References: <000f01c09b5f$188bd6f0$230d0dc3@test>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paolo Marini wrote:
>
> Anybody tried out a 2.4 kernel on the Embedded Planet RPX Net board with 855
> processor ?

Yeah, but I didn't know they were actually going to ship that
board as a product.

> .... I
> suppose the normal kernel configured for an 860 CPU (without the peripherals
> present in the 860 and removed on the 855) works on this board

Almost.  There are a few subtle differences in some board control
registers.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
