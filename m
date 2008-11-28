Return-Path: <carlos.moratelli@digitel.com.br>
Received: from ares.digitel.com.br (cosmos.digitel.com.br [200.198.105.42])
	by ozlabs.org (Postfix) with ESMTP id DC59CDDDE0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Nov 2008 23:16:52 +1100 (EST)
Subject: MPC8313 and Marvell PHY 88e1112
From: Carlos Roberto Moratelli <carlos.moratelli@digitel.com.br>
To: Linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Fri, 28 Nov 2008 10:06:34 -0200
Message-Id: <1227873994.3812.21.camel@parana>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I am working in a custom board based on a mpc8313erdb and my Kernel
version is 2.6.24. This board has a Marvell PHY 88E1112 on TSEC2
processor port. 

The problem is that the PHY is detected and configured, but no data can
be send or received. I am sure that dtb is fine. In another custom board
I have a 88e3015 on TSEC2 and it is working fine.

Did someone work with this PHY? Does Compiling gianfar and Marvell
support on Kernel is enough? 

Thanks,

Carlos R. Moratelli
