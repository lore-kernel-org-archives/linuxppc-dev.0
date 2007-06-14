Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 364D1DDE46
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jun 2007 11:43:25 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1HyeMr-0005WS-QM
	for linuxppc-embedded@ozlabs.org; Wed, 13 Jun 2007 18:43:21 -0700
Message-ID: <11112197.post@talk.nabble.com>
Date: Wed, 13 Jun 2007 18:43:21 -0700 (PDT)
From: Leonardo Araujo <leonardoaraujo.santos@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Steps needed to get Linux 2.6 Running on Xilinx ML403
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi guys I just bouht a ML403 board and started to study how can I get Linux
2.6 working in this board.... My questions are.....

1)The most prepared source tree is the
http://source.mvista.com/git/gitweb.cgi?p=linux-xilinx-26.git;a=log
there I will have the linux prepared to work with Video and network devices
installed on my board?

2)I must use ELDK with this source to provide basic functionality to my
Linux working on my board as gcc, gdb....?

3)Reading some previous posts... I saw some steps used to compile the Linux
... are they right?
3.1) Use EDK 8.2.02 to generate the base system for ml403. EDK generated BSP
files.
3.2)Copy the linux-2.6.20.tar.bz2 into proper location in eldk directory and
extracted there, Then copy all of the BSP files into the root folder of my
kernel source.
3.3)Edit the Makefile and set the ARCH and CROSS_COMPILE variables , also I
set all of the env variables needed by edk. 

4) Ok now I got my kernel compiled in my Computer..... how do I transfer
this kernel to my CF card on board?.... I must do some kind o bzimage....?


Thanks 
Leonardo Araujo dos Santos
leonardoaraujo.santos@gmail.com
-- 
View this message in context: http://www.nabble.com/Steps-needed-to-get-Linux-2.6-Running-on-Xilinx-ML403-tf3918874.html#a11112197
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
