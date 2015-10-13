Return-Path: <jmoyer@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE9571A0743
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 03:47:05 +1100 (AEDT)
From: Jeff Moyer <jmoyer@redhat.com>
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: <axboe@kernel.dk>, <linuxppc-dev@lists.ozlabs.org>,
 <ming.lei@canonical.com>, <keith.busch@intel.com>,
 <snitzer@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block-mq:Fix the null memory access while setting tags
 cpumask
References: <1444713927-16261-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
Date: Tue, 13 Oct 2015 12:47:00 -0400
In-Reply-To: <1444713927-16261-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 (Raghavendra K. T.'s message of "Tue, 13 Oct 2015 10:55:27 +0530")
Message-ID: <x491tcy7m2j.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com> writes:

> In nr_hw_queues >1 cases when certain number of cpus are onlined/or
> offlined, that results change in request_queue map in block-mq layer,
> we see the kernel dumping like:

What version is that patch against?  This problem should be fixed by the
patch set from Akinobu Mita.  I tested cpu hot-plugging on my system
with an nvme device, and it is fixed there on mainline.

Cheers,
Jeff
