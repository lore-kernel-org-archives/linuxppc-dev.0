Message-ID: <000e01c01db8$b5289ea0$481877d3@ajou.ac.kr>
From: "Min-kyu, Joo" <zzu@cesys.ajou.ac.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: I want to find flash device driver...
Date: Thu, 14 Sep 2000 04:27:34 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I use flash in Linux...
I want to use flash after booting linux, making filesystem and mounting flash, and read and write to flash...
So I need flash device driver...
I wrote driver code for flash..because my linux read compressed kernel image from flash..
But when I access flash from system call(open, read, write), it seems to be some problem..

Does anyone know where can I get flash device driver for linux?

--zzu--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
