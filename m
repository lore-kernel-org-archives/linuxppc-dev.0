Message-ID: <3EFAF094.8030705@dgt-lab.com.pl>
Date: Thu, 26 Jun 2003 15:09:40 +0200
From: Wojciech Kromer <krom@dgt-lab.com.pl>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: pcf8563 and i2c kernel abstarct
References: <3EFAE8F1.4010406@dgt-lab.com.pl>
In-Reply-To: <3EFAE8F1.4010406@dgt-lab.com.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


.... i've forgot to call si2c_init before, now there is another starnge
thig, here is my backtrace

#0  add_wait_queue_exclusive (q=0xc01ba738, wait=0xc03f7f28)
    at linux/include/linux/list.h:44
#1  0xc00095bc in __down (sem=0xc01ba730) at semaphore.c:79
#2  0xc00e83a0 in i2c_add_driver (driver=0xc017d3fc)
    at linux/include/asm/semaphore.h:94
#3  0xc018deb0 in pcf8563_rtc_init () at pcf8563.c:265
#4  0xc018d92c in misc_init () at misc.c:270
#5  0xc018d1b0 in chr_dev_init () at mem.c:677
#6  0xc01866dc in do_initcalls () at init/main.c:474
#7  0xc0186724 in do_basic_setup () at init/main.c:558
#8  0xc0002294 in init (unused=0x1) at init/main.c:574
#9  0xc0006d24 in kernel_thread () at time.c:447



--
* * * * * * * * * * * *
* per pedes ad astra! *
* * * * * * * * * * * *    mailto:krom@dgt-lab.com.pl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
