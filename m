Return-Path: <guojin02@tsinghua.org.cn>
Received: from tsinghua.org.cn (mail.tsinghua.org.cn [210.77.143.232])
	by ozlabs.org (Postfix) with SMTP id E2AD3DDEEC
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Mar 2008 00:51:28 +1100 (EST)
Message-ID: <404550515.21147@tsinghua.org.cn>
From: "=?gb2312?B?ufm+og==?=" <guojin02@tsinghua.org.cn>
To: support.asia@freescale.com, b09033@freescale.com,
	linuxppc-embedded@ozlabs.org
Date: Mon, 03 Mar 2008 21:21:55 +0800
Message-ID: <MCUYTANHJGOQYTPDFFVWROJQBRZP.guojin02@tsinghua.org.cn>
Subject: The problem about the GETH speed on MPC8360?
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

Hi,freescale,

   I used the linux-2.6.11 version. I designed the MPC8360 system with 1GB DDR-1
memory and the GMII 1 to interface the 88E1111(RJ45) and GMII 2 to interface the
BCM5387 switch chip(SFP). Now we do the internet test for those GETH. We connect
those RJ45 or SFP to server PC.We used "iperf" test software to test them.

 Follow is the test result:
   UDP protocol: 
      Server PC send 1GB data to MPC8360, the speed is about 300Mbps, MPC8360 CPU
used 100%;
      MPC8360 send 1GB data to Server PC, the speed is about 600Mbps,MPC8360 CPU
used 100%;
     Server PC send 100MB data to MPC8360, and MPC8360 send 100MB to server PC at
the same time, both send and receiver of MPC8360 is 100Mbps. MPC8360 CPU used
100%;

   TCP protocol:
       Server PC send 1GB data to MPC8360, the speed is about 250Mbps, MPC8360 CPU
used 100%;
       MPC8360 send 1GB data to Server PC, the speed is about 6Mbps,MPC8360 CPU
used 20%;

   The problem is why the speed is so slow and the cpu used so little during the
last TCP test? The Gigebyte internet is only 6M bit per sencond, it's too slow.

 


   Could you help me to test the MPC8360EMDS board and send me the test report?
   Could you tell me why the GETH on MPC8360 is so poor? Even the UDP protocol
just only realize the 100Mbps with the send and receive at the same time on
MPC8360. It just like the 100M internet, not 1000M internet.
   Could you tell me why the TCP protocol is much slower then UTP procotol?   
We need up to about 900Mbps TCP protocol both on send and receive at the same
time.
   
