Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3AC16DF20C
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 02:31:45 +1000 (EST)
Message-ID: <4804D867.4070205@freescale.com>
Date: Tue, 15 Apr 2008 11:31:35 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] 86xx: mark functions static, other minor cleanups
References: <1207933186-20555-1-git-send-email-paul.gortmaker@windriver.com>
	<4804D39C.9000309@freescale.com> <4804D7C4.8060805@windriver.com>
In-Reply-To: <4804D7C4.8060805@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Gortmaker wrote:

> Valid point.  Is there a precedent here -- like a printk indicating
> that the old ID matched, to let the user know?

Not really, but a pr_warning() would be nice.

> Actually on this one, we are OK, since the board support didn't exist
> in the default kernel until I'd just sent it last week.

No problem, then.

-- 
Timur Tabi
Linux kernel developer at Freescale
