Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 083CBDDE43
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Jun 2007 23:16:52 +1000 (EST)
Message-ID: <467A7BE9.2030603@ru.mvista.com>
Date: Thu, 21 Jun 2007 17:23:53 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: OPB vs. PLB DDR Memory Controller
References: <20070620134537.GA11302@cip.informatik.uni-erlangen.de>
In-Reply-To: <20070620134537.GA11302@cip.informatik.uni-erlangen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Thomas,

Thomas Glanzmann wrote:
> Hello,
> I used secretlabs kernel tree and build my hardware once with the obp
> uart and once with the uart lite and compiled in the coresponding
> drivers into the linux kernel.
> 
>         loaded at:     00400000 004951A0
>         board data at: 00000000 0000007C
>         relocated to:  0040402C 004040A8
>         zimage at:     00404EE5 00492F1A
>         avail ram:     00496000 7C9E2378
> 
>         Linux/PPC load: root=/dev/nfs rw ip=on

This cmd line doesn't tell the kernel where the console is.
You could try
   "console=ttyS0,9600 root=/dev/nfs rw ip=on" (if the UART is 16x50)
or
   "console=ttyUL0 root=/dev/nfs rw ip=on" (if the UART is UART Lite)

Thanks,
Andrei


>         Uncompressing Linux...done.
>         Now booting the kernel
> 
> As you can see the embedded boot loader works, but the kernel does not
> produce any output. I wonder if I have to configure Linux that it has a
> OPB Memory Controller instead of a PLB Memory Controller. I used the
> ml403 Option in my kernel config.
> 
>         Thomas
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
