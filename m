Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc3-s41.bay0.hotmail.com (bay0-omc3-s41.bay0.hotmail.com
	[65.54.246.241]) by ozlabs.org (Postfix) with ESMTP id 88402DDE40
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Feb 2007 23:12:07 +1100 (EST)
Message-ID: <BAY110-F207F3618DF66A6C22A8E8AB29D0@phx.gbl>
In-Reply-To: <1170927669.10662.4.camel@Serge-Linux>
From: "Ming Liu" <eemingliu@hotmail.com>
To: christophe.alayrac@cresitt.com
Subject: RE: ML403 Hard TEMAC, PLB and Linux 2.6
Date: Thu, 08 Feb 2007 12:12:01 +0000
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

Hi Alayrac,

>Do you mean that you just copy Xilinx linux 2.6 BSP to Kernel.org source
>code directly?
>Or is it a pre patched kernel source tree?
>Could you also precise the kernel version?

Yes. Just use the generated driver source code to overwrite the original 
one in the kernel source. Of course, some fitting must be needed to make 
sure there is no error when compilation. That's very common during 
compilation.

BR
Ming

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn  
