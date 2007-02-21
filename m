Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4C5C9DDE00
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 11:57:02 +1100 (EST)
Message-ID: <45DB98D6.3060004@am.sony.com>
Date: Tue, 20 Feb 2007 16:56:54 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 5/14] zImage: Add more flexible gunzip convenience
	functions
References: <20070220021235.042ABDDD0E@ozlabs.org>
In-Reply-To: <20070220021235.042ABDDD0E@ozlabs.org>
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
> This patch adds a new set of more flexible convenience wrappers around
> zlib, moving them to their own file, gunzip_util.c, in the process.
> These wrappers allow decompressing sections of the compressed image to
> different locations.  In addition, they transparently handle
> uncompressed data, avoiding special case code to handle uncompressed
> vmlinux images.

I tested this on on PS3 without trouble.

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
