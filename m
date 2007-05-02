Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4D5F2DDF8D
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 00:21:40 +1000 (EST)
In-Reply-To: <20070501160538.GA24292@ld0162-tx32.am.freescale.net>
References: <20070501160538.GA24292@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E8649267-DE22-4700-BF33-A9EB744B11DC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Remove duplicate export of __div64_32.
Date: Wed, 2 May 2007 09:20:54 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 1, 2007, at 11:05 AM, Scott Wood wrote:

> Change 3927f2e8f9afa3424bb51ca81f7abac01ffd0005 moved lib/lib64.c from
> lib-y to obj-y, preventing the export in ppc_ksyms.c from overriding
> the one in lib, and thus causing a duplicate-export warning.

I assume you mean lib/div64.c?

- k
