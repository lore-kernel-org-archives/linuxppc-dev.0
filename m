Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
	[213.199.154.141])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 224D8B6F65
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Aug 2011 03:49:53 +1000 (EST)
Message-ID: <4E53E7F8.1050809@freescale.com>
Date: Tue, 23 Aug 2011 12:48:40 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH] powerpc: fixup QE_General4 errata
References: <1314102605-9718-1-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1314102605-9718-1-git-send-email-Joakim.Tjernlund@transmode.se>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Kumar Gala <kumar.gala@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joakim Tjernlund wrote:
> QE_General4 should only round up the divisor iff divisor is > 3.
> Rounding up lower divisors makes the error too big, causing USB
> on MPC832x to fail.
> 
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>

Acked-by: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
