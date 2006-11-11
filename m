Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E2B8567FB7
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 22:28:55 +1100 (EST)
Date: Sat, 11 Nov 2006 12:28:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 13/16] powerpc: add ps3 platform lpar addressing
Message-ID: <20061111112847.GD24288@lst.de>
References: <4554DB14.3070900@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4554DB14.3070900@am.sony.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 10, 2006 at 12:03:32PM -0800, Geoff Levand wrote:
> Adds some needed bits for a config option PS3PF_USE_LPAR_ADDR that disables
> the ps3pf lpar address translation mechanism.  This is a currently needed
> workaround for limitations in the design of the spu support.

So make the code do the sane thing and don't put the config in the
kernel tree.
