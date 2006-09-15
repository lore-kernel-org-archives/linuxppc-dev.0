Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 53E5F67B61
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Sep 2006 11:15:23 +1000 (EST)
Message-ID: <4509FE5C.2070104@dlasys.net>
Date: Thu, 14 Sep 2006 21:14:04 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: John Bonesio <john.bonesio@xilinx.com>
Subject: Re: Ethernet driver for Linux kernel 2.6 running on ML403
References: <2FE3DBF1797A1443AAB3FA0EF6BF4EEC021EA6FA@XSJ-EXCHVS1.xlnx.xilinx.com>
In-Reply-To: <2FE3DBF1797A1443AAB3FA0EF6BF4EEC021EA6FA@XSJ-EXCHVS1.xlnx.xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

John;

    In a related rant. Why is it that there is so much meaningless 
variation in the IP's.

    I accept that there are reasons for sometimes mapping registers via 
dcr and in other IP's making them available directly.
    But why do the assorted bits in what is virtually the same register 
have to keep jumping all over the place ?

    As an example there are enormous similarities between the GEMAC that 
has a driver provided by GHS Integrity, and the
PLB FIFO TEMAC. It is almost possible to build the driver as either with 
just a different set of deffinitions - I spent two weeks
trying unsuccessfully to do just that.



-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
