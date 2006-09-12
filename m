Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 2438367A3F
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Sep 2006 01:54:11 +1000 (EST)
Message-ID: <4506D7DE.9070800@ru.mvista.com>
Date: Tue, 12 Sep 2006 19:53:02 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: "Peter N. Andreasen" <peterarbejde@gmail.com>
Subject: Re: Linux on custom Xilinx board with PPC405 hangs on boot
References: <36468a5c0609120706i6c7e32efke7d8901d9ce4ae9b@mail.gmail.com>
In-Reply-To: <36468a5c0609120706i6c7e32efke7d8901d9ce4ae9b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Peter N. Andreasen wrote:
> I have an FPGA board which is based on the Xilinx ML300 board but 
> without disk and display. It has 4MB flash, and 32MB SDRAM, and uses the 
> uartlite serial port.
> The RAM is located at 0x0000'0000 - 0x01FF'FFFF
> I downloaded the kernel from Montavista, built a board support package 
> in Xilinx Platform Studio, and managed to configure and build the kernel.
> However when I transfer the resulting zImage.elf file to the board, the 
> attached terminal only shows:
> 
> loaded at:     00040000 00D4140E
> board data at: 00D41183 00D41105
> relocated to:  0004258F 00043501
> zimage at:     00048550 0074E751
> initrd at:     00740800 00D420FF
> avail ram:     00D40500 20000000
> 
> Linux/PPC load: root=/dev/ram rw console=/dev/ttyS0
...

"console=ttyS0" (not "/dev/ttyS0" BTW) is for 16x50 compatible UART.
UartLite needs something like "console=ttl0".
