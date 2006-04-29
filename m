Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 147EF679F5
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Apr 2006 01:20:52 +1000 (EST)
Date: Sat, 29 Apr 2006 10:19:36 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: Re: please pull powerpc.git 'merge' branch
Message-ID: <20060429151936.GM5518@pb15.lixom.net>
References: <17491.1134.565353.149941@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17491.1134.565353.149941@cargo.ozlabs.ibm.com>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, torvalds@osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 29, 2006 at 04:15:10PM +1000, Paul Mackerras wrote:

> Anton Blanchard:
>       powerpc: Add cputable entry for POWER6

I never saw this posted to the list.

+#define PPC_FEATURE_ARCH_2_05 0x00001000

Previously we've said implementation instead of specification
("PPC_FEATURE_POWER5_PLUS" etc). That's better than saying base
architecture version, since there are parts of the arch that might or
might not be implemented (i.e. optional features, etc).

> Paul Mackerras:
>       powerpc/pseries: Tell firmware our capabilities on new machines

I never saw this one on the list either.

Don't you want to fall back to the ELF method if the prom call fails
(ret != 0)? Right you close and return.


-Olof
