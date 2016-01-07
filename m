Return-Path: <computersforpeace@gmail.com>
Received: from mail-pa0-x22c.google.com (mail-pa0-x22c.google.com
 [IPv6:2607:f8b0:400e:c03::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E75341A17BA
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 05:54:11 +1100 (AEDT)
Received: by mail-pa0-x22c.google.com with SMTP id uo6so246895358pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jan 2016 10:54:11 -0800 (PST)
Date: Thu, 7 Jan 2016 10:54:06 -0800
From: Brian Norris <computersforpeace@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@au1.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.com>
Subject: Build failure: -Wno-unused-const-variable DNE on old GCC
Message-ID: <20160107185406.GA65420@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm using a GCC 4.6.3 compiler for some compile tests, and I noticed
that commit 2cd55c68c0a4 ("cxl: Fix build failure due to -Wunused-variable
behaviour change") breaks my builds, because the
-Wno-unused-const-variable doesn't exist on GCC 4.6.3.

  drivers/misc/cxl/base.c: At top level:
  cc1: error: unrecognized command line option "-Wno-unused-const-variable" [-Werror]

Any thoughts on how to best fix this? I'd like not to have to scrounge
up a new cross compiler just for build tests.

Regards,
Brian
