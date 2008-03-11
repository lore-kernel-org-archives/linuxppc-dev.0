Return-Path: <guojin02@tsinghua.org.cn>
Received: from tsinghua.org.cn (unknown [210.77.143.232])
	by ozlabs.org (Postfix) with SMTP id 43627DDEFF
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Mar 2008 12:53:15 +1100 (EST)
Message-ID: <405199098.26547@tsinghua.org.cn>
From: "=?gb2312?B?ufm+og==?=" <guojin02@tsinghua.org.cn>
To: linuxppc-embedded@ozlabs.org
Date: Tue, 11 Mar 2008 09:31:38 +0800
Subject: The question about the QUICC ENGINE microcode for freescale PowerPC?
Content-Type: text/plain
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

Hi,friends,

I want to realize the high speed TCP package on GETH of MPC8360E,I would like the
speed on both UCC1 and UCC2 for both send and receive TCP package(big package) up
to 1000M bits/sec, so the total internet speed is 4000M bits/sec for MPC8360E.

I tested the internet performance by IPERF test software with the condition that
the core cpu deal with the TCP package,without microcode. I config the UCC2 down,
config UCC1 to send package out to an server PC,no receive,the speed for UCC1 just
only sending package is about 300M bits/sec, and CPU is 100% used. This speed is
so slow, is too slow. If I send and recieve at the same time, the speed is much
slower, if I make the UCC2 up, the speed is much slower and slower.
I do not know how to incrase the internet speed for MPC8360E, somebody told me, we
must use the microcode for QUICC ENGINE.  

My question is that where can I download the microcode for QUICC ENGINE and how to
use it?  Whether or not this microcode can help me to realize the 4000M bits/sec
for TCP package?
