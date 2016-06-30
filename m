Return-Path: <BATV+bbffa7db79d372be7ab8+4694+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rg8yW1mhLzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 16:38:59 +1000 (AEST)
Date: Wed, 29 Jun 2016 23:38:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Fam Zheng <famz@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Jens Axboe <axboe@kernel.dk>,
 "Ed L. Cashin" <ed.cashin@acm.org>, Jiri Kosina <jikos@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Shaohua Li <shli@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Keith Busch <keith.busch@intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
 dan.j.williams@intel.com
Subject: Re: [PATCH v2 00/12] gendisk: Generate uevent after attribute
 available
Message-ID: <20160630063839.GA17205@infradead.org>
References: <20160630015953.6888-1-famz@redhat.com>
 <20160630062442.GA19761@infradead.org>
 <20160630063554.GE23296@ad.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160630063554.GE23296@ad.usersys.redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 30, 2016 at 02:35:54PM +0800, Fam Zheng wrote:
> also more code and less flexible IMO.  For example, we need at least two
> variants, for attribute_group and device_attribute separately, right?

Yes, or maybe just a calling convention that just passes both.
