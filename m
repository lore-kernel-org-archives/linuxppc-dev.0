Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 137ACDDDFF
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2007 23:46:42 +1000 (EST)
To: Jerry Van Baren <gvb.uboot@gmail.com>
Subject: Re: [PATCH] Fix the -S to modify the totalsize properly. 
In-Reply-To: Your message of "Thu, 19 Apr 2007 22:22:35 EDT."
	<20070420022235.GA1703@dellserver.lan>
References: <20070420022235.GA1703@dellserver.lan> 
Date: Fri, 20 Apr 2007 08:46:37 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1HetRd-0003Y8-F2@jdl.com>
Cc: linuxppc-dev@ozlabs.org, u-boot-users@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Jerry Van Baren mumbled:
> With the last improvement to pad out the blob, I broke the blob
> header totalsize adjustment.  The adjustment was moved up in the
> code before the memory image of the blob is created.
> 
> Signed-off-by: Gerald Van Baren <vanbaren@cideas.com>

Applied!

> Hi Jon,
> 
> This fixes my header totalsize screwup.  Until this is applied, the -S
> adds padding but is not effective.
> 
> My apologies,

[Vader Voice]
    Apology... accepted.
[/Vader Voice]

Thanks,
jdl
