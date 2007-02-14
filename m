Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc2-s16.bay0.hotmail.com (bay0-omc2-s16.bay0.hotmail.com
	[65.54.246.152]) by ozlabs.org (Postfix) with ESMTP id E3A86DDE26
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Feb 2007 02:10:41 +1100 (EST)
Message-ID: <BAY110-F18161E498654AD174D62BBB2970@phx.gbl>
In-Reply-To: <OF229BF134.4671531A-ON85257282.005139A1-85257282.0051498A@ct.wec.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: Glenn.G.Hart@us.westinghouse.com
Subject: RE: Linux w/ML403 PLB TEMAC
Date: Wed, 14 Feb 2007 15:10:36 +0000
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

Hi Glenn,

>I have my own program to test performance.  It seems everything is so slow
>it does not every complete to give me the statistics.  My ping are also
>slower.  I used to be able to ping my computer and get 0.6-0.7 ms times.
>With the DMA and TEMAC v3 I am now getting 1.8 ms times.

I am also struggling with the speed issue. :) Rick is the expert and I am 
also asking him on this problem. 

For your problem, I suggest you to use a general test software like netperf 
first. Then it can bypass the problem in your own test program.

In my system, the ping speed is also slow. From board to pc is 2.1ms and 
from pc to board is 1.8ms. 

>I am now not sure if it is my build or my PPC design.  For the PPC design 
I
>have a minimum PPC with OPB-RS232, PLB-DDR, and PLB-TEMAC.  I use all the
>defaults from BSB except I check use interrupt on the RS232 and TEMAC.

This should not be a problem because the platform is so common. 

BR
Ming

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn  
