Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc2-s27.bay0.hotmail.com (bay0-omc2-s27.bay0.hotmail.com
	[65.54.246.163]) by ozlabs.org (Postfix) with ESMTP id C429E67B6F
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Dec 2006 03:49:33 +1100 (EST)
Message-ID: <BAY110-F3944DE74236D959AF9FB6B2DE0@phx.gbl>
In-Reply-To: <13134516.38521165335487229.JavaMail.servlet@kundenserver>
From: "Ming Liu" <eemingliu@hotmail.com>
To: t.denzinger@lesametric.de
Subject: RE: Speed of plb_temac 3.00 on ML403
Date: Tue, 05 Dec 2006 16:49:28 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
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

Dear Thomas,
Now I am also fighting against improving the performance of the TEMAC on 
ml403 board. But the difference is I work on the old plb_temac and 
hard_temac cores and my linux is 2.6.

I used some little programs written by myself to test the throughput of the 
network between a pc and my board. (I would like to say, I am not an 
experienced programmer so I cannot make sure my programs have no problem, 
although they are simple. :-) ) According to my result, the largest 
throughput between my board and a pc is around 4MB/s, for a round-trip. 
However when those programs applied on two servers interconnected by 
gigabit ethernet, the largest throughput is around 12MB/s, three times than 
my board.

I have not used the popular software, such as Netperf, to measure my little 
network.

I also noticed that when transfering the data, the CPU utilization is very 
high(almost 100%). I am not sure if this is the reason. I think because 
there is SGDMA who can deal with data transfer, the CPU utilization should 
not be so high. 

I am also waiting for some suggestions from some experts who are more 
experienced in such field.

Did you ever measure the throughput of your network? If possible, let's 
share some experience. :)

BR
Ming


>From: Thomas Denzinger <t.denzinger@lesametric.de>
>To: <linuxppc-embedded@ozlabs.org>
>Subject: Speed of plb_temac 3.00 on ML403
>Date: Tue, 05 Dec 2006 17:18:07 +0100
>
>Hi all,
>
>I have to interface to a camera with the GigE Vision protocol.
>
>For that I set up a design on ML403 with PPC, Temac and sgDMA. I use 
MontaVista 2.4.20 Linux with the BSP from Xilinx EDK 8.2. The camera vendor 
supplied a library for GigE Vision, which works under Linux.
>The results of some tests showed that I have to insert waiting time 
between frames sent by the camera, otherwise the lib signals errors.
>This leeds to only 1/10 of the needed transfer rate.
>
>My question is now: Has anybody deeper knowledge how ethernet and sgDMA 
works? How deep is the PPC involved in the data transfer? Or does the 
Temac-core handle the datatransfer to DDR-memory autonomous?
>
>I learnd from the camera vendor, that on PCs with special Intel ethernet 
chips, it works outonomous and so the high transfer rate can be 
accomplished.
>
>I'm very interested to get in contact with people who have to interface 
with a GigE Vision camera.
>
>Also interesting is if anybody benchmarked the gigabit ethernet on the 
ML403 hardware. How fast is the gigabit interface realy?
>
>Thomas
>
>
>--
>Thomas Denzinger
>LesaMetric GmbH
>Hauptstrasse 46
>35649 Bischoffen
>
>Tel.: 06444/931928
>Fax : 06444/931912
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded

_________________________________________________________________
√‚∑—œ¬‘ÿ MSN Explorer:   http://explorer.msn.com/lccn  
