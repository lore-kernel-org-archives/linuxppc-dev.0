Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1DA2867DD2
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 05:26:41 +1100 (EST)
Date: Wed, 15 Nov 2006 19:26:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Subject: Re: [PATCH 2/16] add hypervisor support for SPU
Message-ID: <20061115182636.GA21633@lst.de>
References: <200611150928.kAF9SkJN021123@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200611150928.kAF9SkJN021123@toshiba.co.jp>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 15, 2006 at 06:28:46PM +0900, Ishizaki Kou wrote:
> This patch adds hypervisor support for spu.
> 
> Linux(GuestOS) needs to designate SPE ID number when it uses SPE on Beat,
> and must read the number from DT.

In addition to the comments from Arnd which I'd like to second, what
do you need int_mask_lock for?  It's initialized but never used.
