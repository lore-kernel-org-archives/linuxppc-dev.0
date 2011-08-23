Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE010.bigfish.com (va3ehsobe010.messaging.microsoft.com
	[216.32.180.30]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 51350B6F68
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Aug 2011 04:38:22 +1000 (EST)
Message-ID: <4E53F392.1080702@freescale.com>
Date: Tue, 23 Aug 2011 13:38:10 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH 8/9] arch/powerpc/sysdev/ehv_pic.c: add missing kfree
References: <1312802283-9107-8-git-send-email-julia@diku.dk>
In-Reply-To: <1312802283-9107-8-git-send-email-julia@diku.dk>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Julia Lawall wrote:
> At this point, ehv_pic has been allocated but not stored anywhere, so it
> should be freed before leaving the function.

Acked-by: Timur Tabi <timur@freescale.com>

FYI, Ashish is no longer with Freescale, so I've taken over maintainership of
ehv_pic.

-- 
Timur Tabi
Linux kernel developer at Freescale
