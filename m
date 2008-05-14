Return-Path: <guojin02@tsinghua.org.cn>
Received: from tsinghua.org.cn (unknown [210.77.143.232])
	by ozlabs.org (Postfix) with SMTP id 3CDAEDDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 May 2008 21:54:38 +1000 (EST)
Message-ID: <410764342.21662@tsinghua.org.cn>
From: "=?gb2312?B?ufm+og==?=" <guojin02@tsinghua.org.cn>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 14 May 2008 19:25:42 +0800
Subject: How to test the DDR memory with burst visit mode?
Content-Type: text/plain
Reply-To: =?gb2312?B?ufm+og==?= <guojin02@tsinghua.org.cn>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,friends,
   I designed my MPC8360E board with 1GBytes DDR-1 memory, I built two demo
boards, one is 533/266/400, the other is 660/330/400. The lower frequancy board is
no problem for our program, but the higher frequency board is always problem about
the data transmit on ethernet. 
   I want to test 1GBytes DDR-1 memory, I want to know whether or not the DDR is
stable and accuracy. Could you tell me a simple way that test my DDR memory? 
