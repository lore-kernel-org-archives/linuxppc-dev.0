Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7B5DCDE0B9
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 02:53:48 +1100 (EST)
Message-ID: <49B53B84.4000307@freescale.com>
Date: Mon, 09 Mar 2009 10:53:40 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: clean up ssi.txt, add definition for fsl,
	ssi-asynchronous
References: <1236368634-20317-1-git-send-email-timur@freescale.com>
	<B611A44E-1CB9-48AE-9CB8-979361EC203C@kernel.crashing.org>
In-Reply-To: <B611A44E-1CB9-48AE-9CB8-979361EC203C@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> does not apply cleanly if/after I apply:
> 
> powerpc: add fsl, fifo-depth property to Freescale SSI device nodes

That's weird -- I designed the patch so that it would.  Oh well, I'll
rebase and repost.


-- 
Timur Tabi
Linux kernel developer at Freescale
