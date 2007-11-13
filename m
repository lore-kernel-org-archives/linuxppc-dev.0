Return-Path: <huangyun@coship.com>
Received: from omail.coship.com (unknown [58.61.30.13])
	by ozlabs.org (Postfix) with ESMTP id 8D6D9DDDF7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Nov 2007 14:10:08 +1100 (EST)
Subject: how to improve linux tcp/ip(UDP) efficiency on mpc8541 833Mhz.
To: linuxppc-embedded@ozlabs.org
Message-ID: <OF406A1338.BB8E4414-ON48257392.000CFC61-48257392.000F90D1@coship.com>
From: huangyun@coship.com
Date: Tue, 13 Nov 2007 10:48:47 +0800
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


hi,everbody:
      I have run linux-2.6.15 on my mpc8541 custom board. but when i test
TSEC use UDP, i found it's efficinecy is lower.
my test enviroment: i only run a UDP recieve program and not to handle data
recieved. when i recevie 400Mbps data, 79% of MPC8541 have be consumed.
so i think tcp/ip protocal have consume my mpc8541 resource.  i dont know
how to improve tcp/ip code or TSEC driver(gianfar.c).
      can somebody help me ?



 lucky.huang
