Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C9E0DDE3D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Dec 2007 00:32:29 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1J25Dm-0007au-9P
	for linuxppc-embedded@ozlabs.org; Tue, 11 Dec 2007 05:32:26 -0800
Message-ID: <14274035.post@talk.nabble.com>
Date: Tue, 11 Dec 2007 05:32:26 -0800 (PST)
From: greenlean <jmgomez@atc.ugr.es>
To: linuxppc-embedded@ozlabs.org
Subject: Linux 2.6 from git.xilinx and XUPV2P
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


Hi all,

 I'm a beginner in Xilinx & Linux world and I'm getting a bit loose. I'm
trying to run linux kernel 2.6 that I downloaded from the xilinx git server
on the PPC405 of the Xilinx university program Virtex II Pro (XUPV2P for the
search engine)  board, and I'm using the compiler ELDK 4.1 (I' ve just read
this compiler may cause some error so I'll change it, and try the 4.0
version) and I'm getting a lot of compilation error  and warning. 

I think this is what I should use, Does anybody if I have to patch this
kernel or if it is still prepatched??

My compiler can find some definitions like TASK_SIZE or CONFIG_KERNEL_START,
now I'm solving it writting  the values manually , I google for the error
and make the definition where it's needed, but I don't think this is a good
idea ;). I think this definitions should be defined in the .config file,
because I found the values I wrote on a posted message in this list.

Maybe somebody could guide me a bit through this kernel compilation, or send
me .config file running. I don't know if a revision in the project is a good
way, to put things in situation for beginers. 

Thanks, any info would be interesting. 



-- 
View this message in context: http://www.nabble.com/Linux-2.6-from-git.xilinx-and-XUPV2P-tp14274035p14274035.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
