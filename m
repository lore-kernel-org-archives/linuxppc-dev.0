Return-Path: <B07421@freescale.com>
Received: from CH1EHSOBE006.bigfish.com (ch1ehsobe005.messaging.microsoft.com
	[216.32.181.185]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2F5E7B6F18
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jun 2011 02:43:47 +1000 (EST)
Date: Wed, 29 Jun 2011 11:43:29 -0500
From: Scott Wood <scottwood@freescale.com>
To: <dedekind1@gmail.com>
Subject: Re: [PATCH 2/2] mtd/nand : workaround for Freescale FCM to support
	large-page Nand chip
Message-ID: <20110629114329.154aaef2@schlenkerla.am.freescale.net>
In-Reply-To: <1309328529.23597.106.camel@sauron>
References: <1309225852-1664-1-git-send-email-b35362@freescale.com>
	<1309225852-1664-2-git-send-email-b35362@freescale.com>
	<1309328529.23597.106.camel@sauron>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, b35362@freescale.com, dwmw2@infradead.org,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 29 Jun 2011 09:22:04 +0300
Artem Bityutskiy <dedekind1@gmail.com> wrote:

> On Tue, 2011-06-28 at 09:50 +0800, b35362@freescale.com wrote:
> > +	/* Hack for supporting the flash chip whose writesize is
> > +	 * larger than 2K bytes.
> > +	 */
> 
> Please, use proper kernel multi-line comments. Please, make sure
> checkpatch.pl does not generate 13 errors with this patch.

Most of the checkpatch complaints are about existing style in the file --
particularly, the use of tabs only for indentation, with spaces used for
alignment beyond the indentation point.

-Scott
