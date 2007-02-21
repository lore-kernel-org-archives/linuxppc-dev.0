Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3E7BBDDE00
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 11:58:29 +1100 (EST)
Message-ID: <45DB98D9.3060503@am.sony.com>
Date: Tue, 20 Feb 2007 16:56:57 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 6/14] zImage: Cleanup and improve prep_kernel()
References: <20070220021235.0998DDDDCA@ozlabs.org>
In-Reply-To: <20070220021235.0998DDDDCA@ozlabs.org>
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> This patch rewrites prep_kernel() in the zImage wrapper code to be
> clearer and more flexible.  Notable changes:

I tested this on on PS3 (no initrd case) without trouble.

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
