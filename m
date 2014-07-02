Return-Path: <bvanassche@acm.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 861BC1A002E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jul 2014 01:35:51 +1000 (EST)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
 by ozlabs.org (Postfix) with ESMTP id AC60F1400B7
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2014 01:35:50 +1000 (EST)
Message-ID: <53B425A3.9090404@acm.org>
Date: Wed, 02 Jul 2014 17:30:43 +0200
From: Bart Van Assche <bvanassche@acm.org>
MIME-Version: 1.0
To: Mike Snitzer <snitzer@redhat.com>, Paul Mackerras <paulus@samba.org>
Subject: Re: Regression in 3.15 on POWER8 with multipath SCSI
References: <20140630103058.GA17747@iris.ozlabs.ibm.com>
 <20140701193907.GA15306@redhat.com>
In-Reply-To: <20140701193907.GA15306@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Vladimir Davydov <vdavydov@parallels.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, dm-devel@redhat.com,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/01/14 21:39, Mike Snitzer wrote:
> (btw, Bart Van Assche also has issues with commit e8099177 due to hangs
> during cable pull testing of mpath devices -- Bart: curious to know if
> your cable pull tests pass if you just revert bcccff93).

Sorry but even with bcccff93 reverted after a few iterations my cable
pull simulation test still causes several tasks to hang in sleep_on_page().

Bart.
