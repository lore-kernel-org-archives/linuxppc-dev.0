Return-Path: <grave@ipno.in2p3.fr>
Received: from ipnmail.in2p3.fr (ipnmail.in2p3.fr [134.158.92.208])
	by ozlabs.org (Postfix) with ESMTP id 16E3567B21
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 19:02:34 +1000 (EST)
Subject: Gb Ethernet on xilinx gemac IP
From: Xavier Grave <grave@ipno.in2p3.fr>
To: linuxppc-embedded@ozlabs.org, ppc dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 08:45:36 +0200
Message-Id: <1150785936.17197.9.camel@ipnnarval>
Mime-Version: 1.0
Reply-To: grave@ipno.in2p3.fr
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm currently running linux with 10/100 MBits xilinx ethernet driver. I
have a memec 2VP20 evaluation board.
We have bought a PCOM2 module in order to have a Gb PHY. I have
implemented an hardware to handle it but whatever linux version I take
(2.4 from denx web site, 2.6.17 from kernel.org), I can't configure a Gb
ethernet driver. And the 10/100 driver don't configure my Gb PHY...

I have compiled my linux kernel based on the ml300 configuration default
config.

Does anyone has an idea ?

Thanks, xavier
