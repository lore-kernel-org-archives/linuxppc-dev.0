Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8D034DE2D6
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Apr 2008 04:09:23 +1100 (EST)
Message-ID: <47F26C4F.7000204@freescale.com>
Date: Tue, 01 Apr 2008 12:09:35 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: =?UTF-8?B?6YOt5Yqy?= <guojin02@tsinghua.org.cn>
Subject: Re: Unable to handle kernel paging request for instruction fetch???
References: <407023539.21267@tsinghua.org.cn>
In-Reply-To: <407023539.21267@tsinghua.org.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

郭劲 wrote:
> Hi,all,
> 
> I run the iperf tool to test the ethernet throughput for my MPC8360E board, after
> about 20 minutes, the exception is happened. Could you tell me why? 
> 
> 
> Unable to handle kernel paging request for instruction fetch
> Faulting instruction address: 0x4e800020
> Oops: Kernel access of bad area, sig: 11 [#1]
> MPC836x MDS
> Modules linked in: encoder mpc_sync k_spi(P)

Can you reproduce it with kallsyms enabled, and without the out-of-tree 
module(s)?

> NIP: 4e800020 LR: c01a08d4 CTR: 00000000

Something branched to a bad address from 0xc01a08d0.  Can you look up 
what line that is in your kernel?

-Scott
