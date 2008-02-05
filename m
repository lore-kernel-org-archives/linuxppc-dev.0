Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id C3966DE0E5
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 03:09:42 +1100 (EST)
Date: Tue, 5 Feb 2008 10:10:17 -0600
From: Olof Johansson <olof@lixom.net>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: compile quirk linux-2.6.24 (with workaround)
Message-ID: <20080205161017.GA26196@lixom.net>
References: <200802031729.12069.bernhard@intevation.de>
	<20080204095121.GA18167@powerlinux.fr>
	<20080205070833.3a5b7c11@zod.rchland.ibm.com>
	<20080205143926.GA9709@powerlinux.fr>
	<20080205091548.724c4e20@zod.rchland.ibm.com>
	<fa686aa40802050724o692ef9e7yf51945225f56da5b@mail.gmail.com>
	<20080205093820.5918a216@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080205093820.5918a216@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Bernhard Reiter <bernhard@intevation.de>,
	debian-powerpc@lists.debian.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 05, 2008 at 09:38:20AM -0600, Josh Boyer wrote:

> Taking a step back though, there will always be odd cases like this as
> we move forward.  Toolchain XXX will eventually not support instruction
> YYYY which will eventually be used, etc.  I'll try to make this
> specific case work because it's scope is quite limited.  But this
> problem as a whole will still remain.

Worst case, if it's only a couple of instructions, they could be covered
the way we usually handle new instructions in the ISA: make a macro for
them and hand-encode them.

See real_205_{read,write}b() in arch/powerpc/kernel/misc_64.S for
example.


-Olof
