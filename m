Message-ID: <003701c024d9$e1f7f200$481877d3@ajou.ac.kr>
From: "Min-kyu, Joo" <zzu@cesys.ajou.ac.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: What is the ioremap() function?
Date: Sat, 23 Sep 2000 06:12:52 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have some question about ioremap() function...

In arch/ppc/mm/init.c file, there is ioremap() function..
What is the main functionality of ioremap()?

It takes two argument...
I must use ioremap() for flash device..

I think first argument is physical address of memory mapped device, so I put that argument physical starting address of flash device. In my case, starting address of flash is 0XE4000000. and I use 4MB flash.
Am I use virtual address for first argument?

So I called ioremap() function with following line.

ioremap(0xE4000000, 1024*1024*4);
Am I correct?

Please answer my question...


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
