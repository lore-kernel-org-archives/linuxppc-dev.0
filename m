Return-Path: <atit@eisodus.com>
Received: from smtp1.iitb.ac.in (smtp2.iitb.ac.in [203.197.62.149])
	by ozlabs.org (Postfix) with SMTP id 6498F67A46
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Feb 2005 17:16:16 +1100 (EST)
Message-ID: <420C4BEA.2010805@eisodus.com>
Date: Fri, 11 Feb 2005 11:38:42 +0530
From: atit <atit@eisodus.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: linux porting on EP852T
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am trying to port linux v2.4 on an embedded planet board. When I load 
the zImzge.elf in ram  I get following :
-----------------------------------------------------
loaded at:  00210000 00282208
relocated to: 00380000 003F2208
board data at: 003EF13C 003EF158
relocated to: 00385304 00385320
zImage at: 0038581D 003EE563
avail ram: 003F3000 01000000

Linux/PPC load: console=ttyS0, 9600 console=tty0 root=/dev/sda2
Uncomressing Linux...done.
Now booting the kernel
a 
----------------------------------------------------------------
and then it stops.  What can be the problem. Is there a port available 
for EP852T.
