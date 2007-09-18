Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8A99DDDE9F
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 00:23:11 +1000 (EST)
In-Reply-To: <20070918122925.GA17481@localhost.localdomain>
References: <20070918120752.GA4859@localhost.localdomain>
	<20070918122925.GA17481@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4F1F43EE-214F-4EB0-82CF-9EC04830ECC6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC][RFC] sysdev/commproc.c: fix build caused by
	undefined symbols
Date: Tue, 18 Sep 2007 09:26:18 -0500
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 18, 2007, at 7:29 AM, Anton Vorontsov wrote:

> cpm_install_handler and cpm_free_handler neither used nor defined
> for arch/powerpc.
>
> This causes MPC8xx build failure, patch used to fix that.

can you add the __res fix, and EXPORT() and do these three as one  
patch and improve the commit message. I'm guessing this all shows up  
when we try to build with CONFIG_MODULES=y.  Put the actual compile  
failures in the commit message.

- k
