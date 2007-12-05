Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 09C8ADDEBD
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 01:47:08 +1100 (EST)
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [FDT][PATCH] Fix padding options 
In-Reply-To: Your message of "Tue, 04 Dec 2007 17:36:08 CST."
	<Pine.LNX.4.64.0712041734580.1979@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0712041734580.1979@blarg.am.freescale.net> 
Date: Wed, 05 Dec 2007 08:47:05 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IzvWj-0005c2-5c@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Kumar Gala mumbled:
> "Add an option to pad the blob that is generated" broke the padding
> support.  We were updating the fdt header after writing it.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Applied.

jdl
