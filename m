Message-ID: <004401c206d6$4ac97580$1a11efcb@industrialDiv.hanasys.co.kr>
Reply-To: "Sangmoon Kim" <dogoil@etinsys.com>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: "Roland Dreier" <roland@topspin.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <022501c20633$cbeb4f10$1a11efcb@industrialDiv.hanasys.co.kr><20020528062351.A2267@home.com><002b01c206cd$59f7a760$1a11efcb@industrialDiv.hanasys.co.kr> <52k7pntsie.fsf@topspin.com>
Subject: Re: map iomem in linux_2_4_dev
Date: Wed, 29 May 2002 15:01:36 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you.
I'll try that.

> >>>>> "Sangmoon" == Sangmoon Kim <dogoil@etinsys.com> writes:
>
>     Sangmoon> Actually, I'm a hardware guy.  In most cases, mapping
>     Sangmoon> UART is not needed, but on the hardware I designed, it
>     Sangmoon> is needed.  Because its physical addres is 0x78000000.
>
> You do not need to remap the UART.  It doesn't matter that 0x78000000
> is its address.  Linux will not get confused between physical address
> of the UART and any virtual address space it may be using.  Just call
> ioremap() and give it the address 0x78000000.  It will give you a
> virtual address you can use to access the UART.
>
> Best,
> Roland
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
