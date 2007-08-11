Return-Path: <jreiser@BitWagon.com>
Received: from ruby.spiritone.com (ruby.spiritone.com [216.99.193.130])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 85F00DDE3C
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 12 Aug 2007 01:30:11 +1000 (EST)
Received: from [192.168.0.4] (216-99-213-225.dsl.aracnet.com [216.99.213.225])
	(authenticated bits=0)
	by ruby.spiritone.com (8.13.6/8.13.4) with ESMTP id l7BFMaHq012057
	for <linuxppc-embedded@ozlabs.org>; Sat, 11 Aug 2007 08:22:37 -0700
Message-ID: <46BDD447.5040903@BitWagon.com>
Date: Sat, 11 Aug 2007 08:22:47 -0700
From: John Reiser <jreiser@BitWagon.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Is it possible to move Kernel Virtual Space to 0xE0000000
References: <f807f08a0708110414p2b9fc7c0s94dd9d10214296d5@mail.gmail.com>
In-Reply-To: <f807f08a0708110414p2b9fc7c0s94dd9d10214296d5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Giving Kernel virtual space to 0xD0000000 and it boots without any problems,
> however when I increase it more to 0xE0000000 it throws Program Exception. I
> will be glad if someone helps me out with refernces for Linux Porting on
> MPCs.

Search for:
	linux "4G/4G split"
This work was active a couple years ago on x86.  The kernel patches
are not trivial, and they cost about 15% in performance of system calls.
But they do provide almost a full 32-bits of address space for user mode.

The problem of "not enough user address space" also is solvable with
money.  Get a 64-bit machine.  It costs more per board but saves
development time, so costs less in the long run unless you are making
more than 10,000 systems.

-- 
