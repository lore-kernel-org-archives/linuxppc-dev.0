Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AB82BDDECA
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 12:12:08 +1000 (EST)
In-Reply-To: <20070510003452.GA483@localhost.localdomain>
References: <11787390792190-git-send-email-becky.bruce@freescale.com>
	<20070510003452.GA483@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <569B1815-242A-4CAC-BEA9-B06EF6A5460B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Move reg_booke.h to include/asm-powerpc
Date: Wed, 9 May 2007 21:11:14 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 9, 2007, at 7:34 PM, David Gibson wrote:

> On Wed, May 09, 2007 at 02:31:19PM -0500, Becky Bruce wrote:
>> This patch moves reg_booke.h from include/asm-ppc to
>> include/asm-powerpc.  This is just a git-mv of the file; no changes
>> were made.  Tested builds of 8540 ADS and Ebony platforms with
>> ARCH=ppc and ARCH=powerpc.
>
> I'd much prefer if we copied rather than moved it to asm-powerpc.  I'm
> hoping we can get rid of the remaining sharing of include files shared
> between ppc and powerpc.  That way we can do cleanups in powerpc
> without worrying about breaking ppc.  In turn that should expedite
> progress towards ditching arch/ppc entirely.

Is there really a concern about this file only existing in arch/powerpc.

- k
