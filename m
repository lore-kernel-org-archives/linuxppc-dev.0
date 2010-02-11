Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 79FC5B7D94
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Feb 2010 03:35:58 +1100 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: Endian/__BYTE_ORDER question
References: <OF43B135B0.EF8D9CB9-ONC12576C7.00588245-C12576C7.00598135@transmode.se>
Date: Thu, 11 Feb 2010 17:35:54 +0100
In-Reply-To: <OF43B135B0.EF8D9CB9-ONC12576C7.00588245-C12576C7.00598135@transmode.se>
	(Joakim Tjernlund's message of "Thu, 11 Feb 2010 17:17:37 +0100")
Message-ID: <m2sk977ms5.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joakim Tjernlund <joakim.tjernlund@transmode.se> writes:

> I am getting confused about on how to test for Endian in the kernel code. In user
> space one uses #if __BYTE_ORDER == __LITTLE_ENDIAN or #if __BYTE_ORDER == __BIG_ENDIAN
>
> I can see lots of kernel headers using this test too

Only outside of __KERNEL__.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
