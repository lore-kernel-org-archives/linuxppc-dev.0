Return-Path: <cmetcalf@mellanox.com>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0092.outbound.protection.outlook.com [157.55.234.92])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rWXP02K99zDqD5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jun 2016 06:46:59 +1000 (AEST)
Subject: Re: possible bug in powerpc LE compat syscalls with 64-bit args
To: Andreas Schwab <schwab@linux-m68k.org>
References: <28c367c1-0f60-cd1d-b443-d3876798a627__12262.0927206755$1466112970$gmane$org@mellanox.com>
 <87r3bwq095.fsf@linux-m68k.org>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <linuxppc-dev@lists.ozlabs.org>, Adhemerval Zanella
 <adhemerval.zanella@linaro.org>, Mike Frysinger <vapier@gentoo.org>
From: Chris Metcalf <cmetcalf@mellanox.com>
Message-ID: <bbf47ca0-97a9-da9e-37a6-544bc9a94736@mellanox.com>
Date: Fri, 17 Jun 2016 16:46:38 -0400
MIME-Version: 1.0
In-Reply-To: <87r3bwq095.fsf@linux-m68k.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6/16/2016 5:42 PM, Andreas Schwab wrote:
> Chris Metcalf <cmetcalf@mellanox.com> writes:
>
>> Reviewing what other platforms do, it seems like powerpc compat mode may
>> have the opposite problem in little-endian mode, since arguments are passed
>> in "hi, lo" order unconditionally in arch/powerpc/kernel/sys_ppc32.c.
> PPC32 is always big-endian.

Sounds good then.

Commit 422b9b9684db ("powerpc/compat: 32-bit little endian machine
name is ppcle, not ppc") made me think there was support for a
little-endian 32-bit mode.

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
