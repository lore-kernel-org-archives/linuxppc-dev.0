Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 09C8767C68
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 08:02:25 +1000 (EST)
In-Reply-To: <17727.55569.981861.182079@cargo.ozlabs.ibm.com>
References: <17727.901.368752.68802@cargo.ozlabs.ibm.com>
	<6908EBCA-E869-4949-8096-34717733E6C1@kernel.crashing.org>
	<17727.55569.981861.182079@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5A1E7134-BDE0-40EA-96FC-B60AAC82BEA9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull powerpc.git 'merge' branch
Date: Wed, 25 Oct 2006 17:02:18 -0500
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


On Oct 25, 2006, at 4:37 PM, Paul Mackerras wrote:

> Kumar Gala writes:
>
>> Can you hold off on the this.  The following patch is still under
>> discussion and the problem exists on more than just PPC.
>
> The patch that I put in fixes the problem in the situation where it
> was found, right?  That the problem may exist on other architectures
> isn't a reason not to fix it here.

Just if we come up with a more general solution.  I guess its ok if  
we paper tape over it, just didn't want to if we decide the change  
should be handled in more generic code.

>
>>> Scott Wood:
>>>       [POWERPC] IPIC: Fix spinlock recursion in set_irq_handler
>
> Paul.
