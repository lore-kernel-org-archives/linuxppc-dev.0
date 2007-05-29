Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3C862DDF30
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 10:19:36 +1000 (EST)
Message-ID: <465B71E3.5080009@freescale.com>
Date: Mon, 28 May 2007 19:20:51 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] powerpc: automatically select QE options
References: <1173732027723-git-send-email-timur@freescale.com>
	<465B14B2.2020804@ru.mvista.com>
In-Reply-To: <465B14B2.2020804@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergei Shtylyov wrote:

>    Grr... this causes menuconfig to complain on non-PPC archs:
> 
> drivers/net/Kconfig:2278:warning: 'select' used by config symbol 
> 'UCC_GETH' refer to undefined symbol 'UCC_FAST'

I submitted a fix for this a LONG time ago.  It was applied to the -mm tree and to Kumar's tree, so I don't know why you don't have it.
