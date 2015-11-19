Return-Path: <BATV+69bf8c536aae7fe38501+4470+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0D28A1A09A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 19:23:31 +1100 (AEDT)
Date: Thu, 19 Nov 2015 00:23:25 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mark Salter <msalter@redhat.com>,
 "James E. J. Bottomley" <JBottomley@odin.com>,
 brking <brking@us.ibm.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-block@vger.kernel.org
Subject: Re: kernel BUG at drivers/scsi/scsi_lib.c:1096!
Message-ID: <20151119082325.GA11419@infradead.org>
References: <1447838334.1564.2.camel@ellerman.id.au>
 <1447855399.3974.24.camel@redhat.com>
 <1447894964.15206.0.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1447894964.15206.0.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It's pretty much guaranteed a block layer bug, most likely in the
merge bios to request infrastucture where we don't obey the merging
limits properly.

Does either of you have a known good and first known bad kernel?
