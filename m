Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 93AE467EEE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Aug 2005 20:34:26 +1000 (EST)
Message-ID: <4301C22F.2070006@ru.mvista.com>
Date: Tue, 16 Aug 2005 14:38:39 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
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

Keith J Outwater wrote:
> Hello all - 
> I am designing an embedded system using a Xilinx Virtex II Pro FPGA.
> Can anyone point me to the "best" kernel source tree to use ?
> "Best" in this case means:
> 1. A 2.4 series kernel with good support for Xilinx peripheral devices 
> (existing Xilinx ML300 support is fine).
> 2. Good stability
> 
> By default I'll use the Montavista linuxppc_2.4 tree unless there is a 
> better choice out there.

If you mean the rsync access to source.mvista.com::linuxppc-2.4
then yes, this is the most recent (as regards to Virtex II Pro support)
community 2.4 tree.

Thanks,
Andrei

> Thanks!
> 
> Keith
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
