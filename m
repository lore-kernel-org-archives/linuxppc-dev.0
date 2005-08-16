Return-Path: <peter.ryser@xilinx.com>
Received: from mail6-kan-R.bigfish.com (mail-kan.bigfish.com [63.161.60.29])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 240BE67F3F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Aug 2005 14:36:19 +1000 (EST)
Message-ID: <4301686E.6020904@xilinx.com>
Date: Mon, 15 Aug 2005 21:15:42 -0700
From: Peter Ryser <peter.ryser@xilinx.com>
MIME-Version: 1.0
To: Keith J Outwater <kjoutwater@raytheon.com>
References: <OF688E8333.A7E991BA-ON0725705E.00780121-0725705E.00787A39@mck.us.ray.com>
In-Reply-To: <OF688E8333.A7E991BA-ON0725705E.00780121-0725705E.00787A39@mck.us.ray.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Best kernel for Xilinx VirtexII Pro/PPC405 ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

You might want to look at Xilinx Application Note 765 (XAPP765, 
http://www.xilinx.com/bvdocs/appnotes/xapp765.pdf) for some instructions 
on how to get started with EDK and Linux. All source is published in 
linuxppc-2.4.

- Peter


Keith J Outwater wrote:

>Hello all - 
>I am designing an embedded system using a Xilinx Virtex II Pro FPGA.
>Can anyone point me to the "best" kernel source tree to use ?
>"Best" in this case means:
>1. A 2.4 series kernel with good support for Xilinx peripheral devices 
>(existing Xilinx ML300 support is fine).
>2. Good stability
>
>By default I'll use the Montavista linuxppc_2.4 tree unless there is a 
>better choice out there.
>
>Thanks!
>
>Keith
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
>  
>
