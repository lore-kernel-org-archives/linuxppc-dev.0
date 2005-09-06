Return-Path: <thisismevinay@yahoo.co.in>
Received: from web8405.mail.in.yahoo.com (web8405.mail.in.yahoo.com
	[202.43.219.153]) by ozlabs.org (Postfix) with SMTP id 0C28068077
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Sep 2005 23:07:12 +1000 (EST)
Message-ID: <20050906130029.74727.qmail@web8405.mail.in.yahoo.com>
Date: Tue, 6 Sep 2005 14:00:29 +0100 (BST)
From: vinay hegde <thisismevinay@yahoo.co.in>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: Regarding the PPC board bringup with Linux 2.6 kernel 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,
  
I am working on bringing up a PowerPC based board
with Linux 2.6 kernel (Board supoort package).
However, I am facing some problem with respect to
debugging.
 
When I boot the board with the Linux kernel (BSP),
the board hangs after printing the following
information.
  
>>>>>>>>>>>>>>>>>>>>>>>

Network Loading from: /dev/enet0 

Client IP Address      = 192.168.4.38 
Server IP Address      = 192.168.4.101 
Gateway IP Address     = 192.168.4.253 
Subnet IP Address Mask = 255.255.255.0 
Boot File Name         = developer.kdi 
Load Address           = 04000000 
Buffer Size = 2000000 

Network Boot File Load Start - Press <ESC> to
Bypass, <SPC> to Continue 


Bytes Received =&6141952, Bytes Loaded =&6141952 
Bytes/Second   =&511829, Elapsed Time =12 Second(s) 

Boot Device       =/dev/enet0 
Boot File         =developer.kdi 
Load Address      =04000000 
Load Size         =005DB800 
Execution Address =04000020 
Execution Offset  =00000020 

Passing control to the loaded file/image. 
loaded at:     00800000 00DD8800 
zimage at:     008058E0 009933BB 
initrd at:     00998000 00DD8800 
avail ram:     00400000 00800000 

Linux/PPC load: console=ttyS0,9600 console=tty0
root=/dev/sda2  console=ttyS0,9600 root=/dev/ram rw 
Uncompressing Linux...done. 
Now booting the kernel 
 
 
>>>>>>>>>>>>>>>>>>>>>. 

I am going through the source code to figure out the
problem, but unable to find out what is going wrong
here.
 
Does anybody have any idea about the problem? Also,
is it possible to print some debug messages at this
point of booting? {Note that, in the early stage of
booting process the serial is initialized and all
the above mentioned messages (like Uncomressing
Linux, Now booting the kernel etc) are printed. And
immediately after printing the "now booting the
kernel message,the serial is closed. This code is in
uncompress_kernel() function in
arch/ppc/boot/simple/misc.c file).

Can somebody help me with the above problem?

Thank you,
vinay hegde.


	

	
		
__________________________________________________________ 
Yahoo! India Matrimony: Find your partner online. Go to http://yahoo.shaadi.com
