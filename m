Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2187CDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 10:41:54 +1000 (EST)
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B04B342D4@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B04B342D4@ismail.innsys.innovsys.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <189c557681b0bc758b2e7c31afcd4df6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Comiler error compiling 2.6.26
Date: Wed, 16 Jul 2008 02:41:17 +0200
To: "Rune Torgersen" <runet@innovsys.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Trying to cross-compile arch/powerpc for an freescale 8280:
>
> Gcc 4.1.2
> Binutils 2.17
>
> BFD: ./vmlinux.strip.7812: section .text lma 0xc0000000 overlaps
> previous sections

[etc]

Could you try with binutils 2.18?  If not, or if that doesn't help,
we'll need to see your .config .


Segher
