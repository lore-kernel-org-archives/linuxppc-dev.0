Return-Path: <BATV+e0efdd19ce80d487e3da+5372+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gz0l2B15zF2Pn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 00:15:51 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Ed L. Cashin" <ed.cashin@acm.org>, Geoff Levand <geoff@infradead.org>,
 Maxim Levitsky <maximlevitsky@gmail.com>, linux-block@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org,
 sparclinux@vger.kernel.org
Subject: make a few block drivers highmem safe
Date: Wed,  9 May 2018 15:59:41 +0200
Message-Id: <20180509135948.20329-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

this series converts a few random block drivers to be highmem safe,
in preparation of eventually getting rid of the block layer bounce
buffering support.
