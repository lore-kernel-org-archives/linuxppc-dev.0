Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 57B4667B32
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 08:39:44 +1000 (EST)
Date: Tue, 18 Jul 2006 17:38:54 -0500
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: [PATCH 0/3] powerpc: Instrument Hypervisor Calls
Message-ID: <20060718223854.GC5238@pb15.lixom.net>
References: <20060718204723.GA6104@w-mikek2.ibm.com>
	<20060718212913.GB3091@w-mikek2.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060718212913.GB3091@w-mikek2.ibm.com>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 18, 2006 at 02:29:13PM -0700, Mike Kravetz wrote:

> 88 1046 108106 109322
[...]
> 104 1 1040 1061

Heh. Shouldn't PURR/TB be <= 1 at all times? :-) I bet this is because
they're not sampled at exactly the same time, etc.

Maybe recoding it to assembly so you can do mftb and mfspr right after
each other, and do the arithmetics/stores later could help. Inline asm
might be sufficient.


-Olof
