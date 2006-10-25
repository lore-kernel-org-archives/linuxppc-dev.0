Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2960A67C67
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 00:10:06 +1000 (EST)
In-Reply-To: <17727.901.368752.68802@cargo.ozlabs.ibm.com>
References: <17727.901.368752.68802@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6908EBCA-E869-4949-8096-34717733E6C1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull powerpc.git 'merge' branch
Date: Wed, 25 Oct 2006 09:09:56 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, torvalds@osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 25, 2006, at 1:26 AM, Paul Mackerras wrote:

> Linus,
>
> Please do:
>
> git pull \
> git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge
>
> to get some more PowerPC bugfixes, as listed below.  There is also a
> defconfig update and the addition of a new processor type (970GX) to
> the cpu table.  The first 4 listed under Ben H.'s name aren't strictly
> bugfixes in themselves, but are needed for the Cell timebase hardware
> bug workaround (the bug is that reads from the timebase may
> occasionally not return monotonically increasing values, as they
> implemented the timebase as two 32-bit counters).

Can you hold off on the this.  The following patch is still under  
discussion and the problem exists on more than just PPC.

[snip]

> Scott Wood:
>       [POWERPC] IPIC: Fix spinlock recursion in set_irq_handler

- kumar
