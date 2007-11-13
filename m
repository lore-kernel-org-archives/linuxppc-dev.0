Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 3AE24DDE1D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Nov 2007 22:32:05 +1100 (EST)
Message-ID: <47398B44.2070902@anagramm.de>
Date: Tue, 13 Nov 2007 12:32:20 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: huangyun@coship.com
Subject: Re: how to improve linux tcp/ip(UDP) efficiency on mpc8541 833Mhz.
References: <OF406A1338.BB8E4414-ON48257392.000CFC61-48257392.000F90D1@coship.com>
In-Reply-To: <OF406A1338.BB8E4414-ON48257392.000CFC61-48257392.000F90D1@coship.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

huangyun@coship.com schrieb:
 > hi,everbody:
 >       I have run linux-2.6.15 on my mpc8541 custom board. but when i test
 > TSEC use UDP, i found it's efficinecy is lower.
 > my test enviroment: i only run a UDP recieve program and not to handle data
 > recieved. when i recevie 400Mbps data, 79% of MPC8541 have be consumed.
 > so i think tcp/ip protocal have consume my mpc8541 resource.  i dont know
 > how to improve tcp/ip code or TSEC driver(gianfar.c).
 >       can somebody help me ?

Hmm... you should first try one of the current kernels and check the
performance there.
For further details about linux networking, I recommend you to contact
the guys at the netdev list, giving lots of details how you do your
benchmarking and how your workload looks like.

Regards,

Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com
