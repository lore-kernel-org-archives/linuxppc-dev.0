Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 259D7DDE20
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 19:30:19 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IO916-0002TK-IZ
	for linuxppc-dev@ozlabs.org; Thu, 23 Aug 2007 02:30:16 -0700
Message-ID: <12290295.post@talk.nabble.com>
Date: Thu, 23 Aug 2007 02:30:16 -0700 (PDT)
From: sivaji <rameshmrm@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: 2.6.23-rc3 is not booting
In-Reply-To: <BEAC6061-FBAC-45EE-9D2A-C0904DDFECAD@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <12268833.post@talk.nabble.com>
	<BEAC6061-FBAC-45EE-9D2A-C0904DDFECAD@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Hi,
           I am using 8641D processor and the silicon revision is 2.0.

Part : MPC8641D
Revision:  2.0
e600 Core Revision:  2.2
DeviceMarking:  B
Processor Version Register Value: 0x8004_0202
System Version Register Value:   0x8090_0120

by
Sivaji

>
> Hai,
>          I am using the kernel 2.6.23-rc3. i am trying to boot this  
> kernel
> to my 8641D board. It was not booting.
> I go the following message
>
> Bytes transferred = 1505 (5e1 hex)
> ## Booting image at 00200000 ...
>    Image Name:   Linux-2.6.23-rc3
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1801717 Bytes =  1.7 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
>    Booting using flat device tree at 0x800000
>
> Whether the problem belongs to device tree? I am using the  
> mpc8641_hpcn.dts
> file
>
> Pls Advice me.

What rev board/silicon do you have?  I'd suggest building the kernel  
w/o PCI support and see what happens.  Make sure you've got the  
latest dts from the kernel tree.

- k


_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev



-- 
View this message in context: http://www.nabble.com/2.6.23-rc3-is-not-booting-tf4309661.html#a12290295
Sent from the linuxppc-dev mailing list archive at Nabble.com.
