Return-Path: <ed.cashin@acm.org>
Received: from gproxy5-pub.mail.unifiedlayer.com
 (gproxy5-pub.mail.unifiedlayer.com [67.222.38.55])
 by lists.ozlabs.org (Postfix) with SMTP id 3rgdLd0RfFzDqhC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 10:58:00 +1000 (AEST)
Subject: Re: [PATCH v2 05/12] aoeblk: Generate uevent after attribute available
To: Fam Zheng <famz@redhat.com>, linux-kernel@vger.kernel.org
References: <20160630015953.6888-1-famz@redhat.com>
 <20160630015953.6888-6-famz@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Jens Axboe <axboe@kernel.dk>, Jiri Kosina <jikos@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Minchan Kim <minchan@kernel.org>,
 Nitin Gupta <ngupta@vflare.org>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Shaohua Li <shli@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Keith Busch <keith.busch@intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@infradead.org>
From: Ed Cashin <ed.cashin@acm.org>
Message-ID: <5775C009.3010000@acm.org>
Date: Thu, 30 Jun 2016 20:57:45 -0400
MIME-Version: 1.0
In-Reply-To: <20160630015953.6888-6-famz@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/29/2016 09:59 PM, Fam Zheng wrote:
> It is documented that KOBJ_ADD should be generated after the object's
> attributes and children are ready.  We can achieve this with the new
> disk_gen_uevents interface.

Looks like an improvement, thanks!

-- 
   Ed
