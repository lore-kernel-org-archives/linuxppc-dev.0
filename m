Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 26599DDF1B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 01:00:32 +1000 (EST)
In-Reply-To: <20070917165731.GC6563@loki.buserror.net>
References: <20070917165731.GC6563@loki.buserror.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9AF6BEAD-F7C3-4FED-989E-D5BE8E7599E2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 03/28] Document local bus nodes in the device tree.
Date: Tue, 18 Sep 2007 10:03:37 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 17, 2007, at 11:57 AM, Scott Wood wrote:

> cuboot-pq2 is updated to match the binding, and get rid of phandle  
> linkage.

A slight more descriptive commit message is desired.

- k

>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  Documentation/powerpc/booting-without-of.txt |   38 +++++++++++++++ 
> +++++++++++
>  arch/powerpc/boot/cuboot-pq2.c               |   29 ++++ 
> +--------------
>  2 files changed, 46 insertions(+), 21 deletions(-)
