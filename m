Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A5CE8679F9
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Apr 2006 03:03:41 +1000 (EST)
Date: Fri, 21 Apr 2006 19:03:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch] powerpc: move PAGE_SIZE outside #ifdef __KERNEL__
Message-ID: <20060421170333.GA4248@lst.de>
References: <4447C3BA.6050709@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4447C3BA.6050709@am.sony.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 20, 2006 at 10:24:10AM -0700, Geoff Levand wrote:
> The procps package needs PAGE_SIZE, defined in asm-powerpc/page.h,
> but it is defined inside "#ifdef __KERNEL__".
> 
> This moves the PAGE_SIZE definition outside of "#ifdef __KERNEL__".

NACK. 
