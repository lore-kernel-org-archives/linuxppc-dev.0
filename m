Return-Path: <mh@omnisys.se>
Received: from mail.omnisys.se (static-213-115-84-26.sme.bredbandsbolaget.se
	[213.115.84.26]) by ozlabs.org (Postfix) with ESMTP id BC3F5DE0D2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 27 Jan 2007 03:11:46 +1100 (EST)
Message-ID: <45BA283F.3040903@omnisys.se>
Date: Fri, 26 Jan 2007 17:11:43 +0100
From: Magnus Hjorth <mh@omnisys.se>
MIME-Version: 1.0
To: Silken Tiger <st@iss.tu-darmstadt.de>
Subject: Re: ML403 hard Ethernet under Linux 2.6.18
References: <689CB232690D8D4E97DA6C76DA098E6C03A7A14D@XCO-EXCHVS1.xlnx.xilinx.com>
	<45B9EBC8.9080509@omnisys.se>
	<200701261341.25914.st@iss.tu-darmstadt.de>
In-Reply-To: <200701261341.25914.st@iss.tu-darmstadt.de>
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

Hi,

Emailed you a large and ugly patch privately..

One thing I discovered while getting this to work is that enabling the 
"Early serial boot texts" feature causes the kernel to crash. That could 
be causing problems for someone else out there...

Regards,
Magnus


Silken Tiger wrote:
> Hi Magnus
>
> It would be really nice if you could send a patch of the changes to make to 
> get 2.6.18 working. I am currently fiddling with an XUP board, and i haven't 
> been really successfull with the edk 8.2.
>
> I would really appreciate it.
> ST
>   


-- 

Magnus Hjorth, M.Sc.
Omnisys Instruments AB
Gruvgatan 8
SE-421 30  Västra Frölunda, SWEDEN
Phone: +46 31 734 34 09
Fax: +46 31 734 34 29
http://www.omnisys.se 
