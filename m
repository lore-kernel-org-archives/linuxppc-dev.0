Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc3-s33.bay0.hotmail.com (bay0-omc3-s33.bay0.hotmail.com
	[65.54.246.233]) by ozlabs.org (Postfix) with ESMTP id 82008DDF05
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 23 Apr 2007 04:18:45 +1000 (EST)
Message-ID: <BAY138-F22BA3703EF02D975AC59BDB2540@phx.gbl>
From: "Ming Liu" <eemingliu@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: where is the sk_buff allocation
Date: Sun, 22 Apr 2007 18:06:35 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear all,
I am reading and understanding the Xilinx Temac device driver. I know that 
hard_start_xmit() is used to transmit the packets. In this function, a 
pointer skb which points to a sk_buff needs to be passed to show the 
location of the socket buffer. But where is that sk_buff allocation 
sentence, and how its address (skb) is passed to the hard_start_xmit() 
function? I want to change the address of the sk_buff in my system and try 
to fit this socket buffer in a pre-defined location.

Thanks for your telling.

BR
Ming

_________________________________________________________________
享用世界上最大的电子邮件系统— MSN Hotmail。  http://www.hotmail.com  
