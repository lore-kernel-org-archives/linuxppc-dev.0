Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B081AB6F7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Sep 2011 08:15:51 +1000 (EST)
Message-ID: <4E80F941.2090408@freescale.com>
Date: Mon, 26 Sep 2011 17:14:25 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx: fix PHYS_64BIT selection for P1022DS
References: <1316806370-21067-1-git-send-email-agust@denx.de>
	<CAOZdJXXw-YMFG4vVbYQKOtDYHtriaXe-=sz6YBivFXbp=mH2PQ@mail.gmail.com>
	<FAF4E48A-0966-4A6E-8D31-B30D07CB0746@kernel.crashing.org>
In-Reply-To: <FAF4E48A-0966-4A6E-8D31-B30D07CB0746@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Anatolij Gustschin <agust@denx.de>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> Why, the way this patch makes it will work both with a 32-bit or 36-bit address map.   The comment should be fixed since its wrong.

I think the BSP team had said that there is a significant performance
improvement in some benchmark when 36-bit support is disabled.  That's why they
like to keep 32-bit and 36-bit environments for both, and why they default to
32-bit.

-- 
Timur Tabi
Linux kernel developer at Freescale
