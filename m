To: "Sangmoon Kim" <dogoil@etinsys.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: map iomem in linux_2_4_dev
References: <022501c20633$cbeb4f10$1a11efcb@industrialDiv.hanasys.co.kr>
	<20020528062351.A2267@home.com>
	<002b01c206cd$59f7a760$1a11efcb@industrialDiv.hanasys.co.kr>
From: Roland Dreier <roland@topspin.com>
Date: 28 May 2002 22:47:21 -0700
In-Reply-To: <002b01c206cd$59f7a760$1a11efcb@industrialDiv.hanasys.co.kr>
Message-ID: <52k7pntsie.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>>>> "Sangmoon" == Sangmoon Kim <dogoil@etinsys.com> writes:

    Sangmoon> Actually, I'm a hardware guy.  In most cases, mapping
    Sangmoon> UART is not needed, but on the hardware I designed, it
    Sangmoon> is needed.  Because its physical addres is 0x78000000.

You do not need to remap the UART.  It doesn't matter that 0x78000000
is its address.  Linux will not get confused between physical address
of the UART and any virtual address space it may be using.  Just call
ioremap() and give it the address 0x78000000.  It will give you a
virtual address you can use to access the UART.

Best,
Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
