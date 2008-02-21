Return-Path: <SRS0+ea5d63d9aa9e89b27c93+1642+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 67248DDE49
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Feb 2008 03:48:42 +1100 (EST)
Date: Thu, 21 Feb 2008 11:48:36 -0500
From: Christoph Hellwig <hch@infradead.org>
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: Block devices
Message-ID: <20080221164836.GA4209@infradead.org>
References: <47BD22D0.9060008@dlasys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47BD22D0.9060008@dlasys.net>
Cc: linux-fsdevel@vger.kernel.org, linux-mtd <linux-mtd@lists.infradead.org>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Feb 21, 2008 at 02:05:52AM -0500, David H. Lynch Jr. wrote:
>     Can I boot an initramfs kernel without a block device ?

Yes.

>     Can I write a filesystem driver for a flash device that does not
> require a block device ?

Yes.

>     Are their any examples of something even close ?

For that particular flash case there's just jffs2 in the kernel tree,
with some more flash filesystems under development.  You can of
course have network and in-memory filesystems aswell.
