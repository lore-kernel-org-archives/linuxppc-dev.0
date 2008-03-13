Return-Path: <guojin02@tsinghua.org.cn>
Received: from tsinghua.org.cn (unknown [210.77.143.232])
	by ozlabs.org (Postfix) with SMTP id 11992DDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Mar 2008 13:26:59 +1100 (EST)
Message-ID: <405373919.31224@tsinghua.org.cn>
From: "=?gb2312?B?ufm+og==?=" <guojin02@tsinghua.org.cn>
To: rmcguire@videopresence.com
Date: Thu, 13 Mar 2008 10:05:19 +0800
Message-ID: <ZCDCMHYFJTSJIDOZLQFVJJBPKCYW.guojin02@tsinghua.org.cn>
Subject: Re:The question about the QUICC ENGINE microcode for freescale
Content-Type: text/plain
Cc: linuxppc-embedded@ozlabs.org
Reply-To: =?gb2312?B?ufm+og==?= <guojin02@tsinghua.org.cn>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,Russell,
My MPC8360 is 533/266/400MHZ(core/ddr/QE), I have 2Gbytes DDR-1 memory, not
DDR-II. I found that the DDR affected the speed if some ddr is not good. I used
the linux-2.6.22 with enable the NAPI driver. I will update my cpu to
667/333/400MHZ.

I written the email to the support.asis@freescale.com, I do not know who will
response this email. Nobody in freescale teach me how to deal with this problem. 

I do not know whether or not each QUICC ENGINE in charge of each GETH? How to
config to make each QE in charge of each GETH?

Thank you very much.


>From: "Russell McGuire" <rmcguire@videopresence.com>
>Reply-To: <rmcguire@videopresence.com>
>To: <guojin02@tsinghua.org.cn>
>Subject: The question about the QUICC ENGINE microcode for freescale
>Date:Tue, 11 Mar 2008 17:20:25 -0700
>
>Couple of thoughts, is that according to Freescale specs, the QE can only
>support TWO 1000Mbit end points. And that is assuming RAW traffic, not
>protocol layer processing. Since the 8360E has two QUICC Engines, that is
>only 1000Mbits data per Engine. Are you intending to get 1000Mbits TX and RX
>on each engine? I think in reality you will be capped at 1000Mbit aggregate
>in the RX and TX. I could be wrong, but you might want to run that past a
>Freescale FAE, do you have the name of your contact for your area?
>
>This is assuming that you are running at the full speed of the MPC8360E, i.e
>both QUICC engines probably pushing 500Mhz. You'll also need to probably be
>running DDR2 RAM at MAX speed to achieve these rates, as each skbuf will
>have to be dma'd out to external memory. All the early dev boards by
>Freescale only used DDR1. As well you'll want to be sure your Coherent
>System Bus <CSB> speed is as near max, i.e. 300-333Mhz.
>
>What clock speeds / Frequency of chip are you using to test this?  As well
>which driver are you using with this test?
>
>As a HW designer for these boards and driver programmer I am just curious
>what your HW is looking / configured like?
>
>-Russ
>
>
>
>
>
>Hi,friends,
>
>I want to realize the high speed TCP package on GETH of MPC8360E,I would
>like the speed on both UCC1 and UCC2 for both send and receive TCP
>package(big package) up to 1000M bits/sec, so the total internet speed is
>4000M bits/sec for MPC8360E.
>
>I tested the internet performance by IPERF test software with the condition
>that the core cpu deal with the TCP package,without microcode. I config the
>UCC2 down, config UCC1 to send package out to an server PC,no receive,the
>speed for UCC1 just only sending package is about 300M bits/sec, and CPU is
>100% used. This speed is so slow, is too slow. If I send and recieve at the
>same time, the speed is much slower, if I make the UCC2 up, the speed is
>much slower and slower.
>I do not know how to incrase the internet speed for MPC8360E, somebody told
>me, we must use the microcode for QUICC ENGINE.  
>
>My question is that where can I download the microcode for QUICC ENGINE and
>how to use it?  Whether or not this microcode can help me to realize the
>4000M bits/sec for TCP package?
>
>
>
>
> 
