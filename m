Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE002.bigfish.com (va3ehsobe002.messaging.microsoft.com
	[216.32.180.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 49630B6F70
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Aug 2011 04:27:34 +1000 (EST)
Message-ID: <4E4D5985.3080300@freescale.com>
Date: Thu, 18 Aug 2011 13:27:17 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: <b35362@freescale.com>
Subject: Re: [PATCH v3] mtd/nand : workaround for Freescale FCM to support
	large-page Nand chip
References: <1313634783-8855-1-git-send-email-b35362@freescale.com>
	<4E4D3CE0.7020602@freescale.com>
In-Reply-To: <4E4D3CE0.7020602@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, dwmw2@infradead.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/18/2011 11:25 AM, Scott Wood wrote:
> The NOP restrictions should be documented in the code itself, not just
> in the git changelog.  Maybe print it to the console when this hack is
> used, along with the NOP value read from the ID.  If it's less than 4
> for 4K or 8 for 8K, also print a message saying not to use jffs2 (does
> yaffs2 do similar things?).  If it's less than 2 for 4K or 4 for 8K, the
> probe should fail.

We should also warn the user about the need to prepare the NAND chip by
copying the bad block markers to the OOB of the new layout.

-Scott
