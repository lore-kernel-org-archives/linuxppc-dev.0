Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVhCq5FDszDqm5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 21:36:07 +1000 (AEST)
Date: Thu, 16 Jun 2016 13:36:00 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: He Kuang <hekuang@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 alexander.shishkin@linux.intel.com, wangnan0@huawei.com,
 adrian.hunter@intel.com, ak@linux.intel.com, maddy@linux.vnet.ibm.com,
 bp@suse.de, dsahern@gmail.com, linux@horizon.com, namhyung@kernel.org,
 linux@rasmusvillemoes.dk, yury.norov@gmail.com, mpe@ellerman.id.au,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] tools include: Adopt byte ordering macros from
 byteorder/generic.h
Message-ID: <20160616113600.GB20646@krava>
References: <1466073692-88702-1-git-send-email-hekuang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466073692-88702-1-git-send-email-hekuang@huawei.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 16, 2016 at 10:41:31AM +0000, He Kuang wrote:
> From: Wang Nan <wangnan0@huawei.com>
> 
> This patch adopts the macros for byte order conversion from
> "include/linux/byteorder/generic.h" to
> "tools/include/linux/byteorder/generic.h"
> 
> tools/perf/MANIFEST is also updated for 'make perf-*-src-pkg'.

other than explanation for the kbuild test robot email:
  http://marc.info/?l=linux-kernel&m=146605819924421&w=2

it looks ok..

jirka
