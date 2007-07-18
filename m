Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E0F65DDEB7
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 14:51:15 +1000 (EST)
In-Reply-To: <20070718013258.GB15238@ld0162-tx32.am.freescale.net>
References: <20070718013258.GB15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D9223336-43B1-4C5C-943B-4ED5E996D220@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 03/61] Only include linux/ide.h if CONFIG_BLOCK is defined.
Date: Tue, 17 Jul 2007 23:51:36 -0500
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


On Jul 17, 2007, at 8:32 PM, Scott Wood wrote:

> The IDE header file uses type definitions that are undefined if the
> CONFIG_BLOCK is deselected.  This causes a compilation failure in
> setup_32.c.

I'm not yet convinced the solution shouldn't be more generic than  
this.  I'm guessing the same issue exists on other platforms if you  
don't have CONFIG_BLOCK enabled.

- k
