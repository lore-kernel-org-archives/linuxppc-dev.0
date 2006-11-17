Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B2E9467BAC
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 17:09:07 +1100 (EST)
Date: Fri, 17 Nov 2006 07:08:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 6/16] powerpc: add support for ps3 platform
Message-ID: <20061117060845.GA13535@lst.de>
References: <455D2FA8.7040808@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <455D2FA8.7040808@am.sony.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 16, 2006 at 07:42:32PM -0800, Geoff Levand wrote:
> This adds the core platform support for the PS3 game console and other
> platforms using the PS3 Platform hypervisor.

Still this uses the braindead ps3pf plattform name, please get rid of it
ASAP!
