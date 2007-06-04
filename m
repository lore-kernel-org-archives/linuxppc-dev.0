Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] kexec ppc64: fix misaligned cmdline 
In-reply-to: <8f5d8a214e9042b0c556ac7256928a52@bga.com> 
References: <25445.1180941825@neuling.org>
	<8f5d8a214e9042b0c556ac7256928a52@bga.com>
Date: Mon, 04 Jun 2007 19:42:16 +1000
Message-ID: <26608.1180950136@neuling.org>
Cc: linuxppc-dev@ozlabs.org, horms@verge.net.au, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> While this appears to fix the stated problem, did you explore my
> suggestion of deleting and creating the property like we do for
> the initrd base and size?

Yeah, but it didn't seem "hapazard" enough for kexec. :-)

> Deleting and recreating should also handle the case of no boot-args in
> the original /chosen sub-tree (when the bootloader didn't (need to)
> supply a command line).

Yeah, we're screwed when the first boot has no bootargs.

Let me get the policy right.  We blow away the old command line except
for the "root=blah" item.  Correct?

Mikey
