Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVxgR4VHnzDqs7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 07:42:27 +1000 (AEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <linuxppc-dev@lists.ozlabs.org>,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 Mike Frysinger <vapier@gentoo.org>
Subject: Re: possible bug in powerpc LE compat syscalls with 64-bit args
References: <28c367c1-0f60-cd1d-b443-d3876798a627__12262.0927206755$1466112970$gmane$org@mellanox.com>
Date: Thu, 16 Jun 2016 23:42:14 +0200
In-Reply-To: <28c367c1-0f60-cd1d-b443-d3876798a627__12262.0927206755$1466112970$gmane$org@mellanox.com>
 (Chris Metcalf's message of "Thu, 16 Jun 2016 11:36:59 -0400")
Message-ID: <87r3bwq095.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Chris Metcalf <cmetcalf@mellanox.com> writes:

> Reviewing what other platforms do, it seems like powerpc compat mode may
> have the opposite problem in little-endian mode, since arguments are passed
> in "hi, lo" order unconditionally in arch/powerpc/kernel/sys_ppc32.c.

PPC32 is always big-endian.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
