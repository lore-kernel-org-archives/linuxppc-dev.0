Return-Path: <sergey.senozhatsky.work@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sF9G5508jzDr30
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 12:36:29 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id h186so667203pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 19:36:29 -0700 (PDT)
Date: Thu, 18 Aug 2016 11:36:33 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Fam Zheng <famz@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@intel.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-block@vger.kernel.org,
 Brian Norris <computersforpeace@gmail.com>,
 Paul Mackerras <paulus@samba.org>, linux-mtd@lists.infradead.org,
 "Ed L. Cashin" <ed.cashin@acm.org>, Jens Axboe <axboe@kernel.dk>,
 Minchan Kim <minchan@kernel.org>,
 virtualization@lists.linux-foundation.org,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Nitin Gupta <ngupta@vflare.org>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 15/15] block: Add FIXME comment to handle device_add_disk
 error
Message-ID: <20160818023633.GC500@swordfish>
References: <1471418115-3654-1-git-send-email-famz@redhat.com>
 <1471418115-3654-16-git-send-email-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471418115-3654-16-git-send-email-famz@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (08/17/16 15:15), Fam Zheng wrote:
[..]
>   (
>     rc = device_add_disk(e1, e2, e3);
>   |
>   + /* FIXME: handle error. */
>     device_add_disk(e1, e2, e3);

or use __must_check for device_add_disk() function?
/* which is _attribute__((warn_unused_result)) */

	-ss
