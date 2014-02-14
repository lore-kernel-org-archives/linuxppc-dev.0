Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x22c.google.com (mail-pb0-x22c.google.com
 [IPv6:2607:f8b0:400e:c01::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3DAB42C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 16:24:38 +1100 (EST)
Received: by mail-pb0-f44.google.com with SMTP id rq2so11826057pbb.17
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Feb 2014 21:24:35 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] of: fix a regression when trying to find the best
 compatible match
Date: Fri, 14 Feb 2014 13:22:44 +0800
Message-Id: <1392355366-1445-1-git-send-email-haokexin@gmail.com>
Cc: Grant Likely <grant.likely@linaro.org>,
 Stephen N Chivers <schivers@csc.com.au>, Rob Herring <robh+dt@kernel.org>,
 Kevin Hao <haokexin@gmail.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This fix a regression when trying to find the best compatible match. You can
find the detail of the issue reported by Stephen Chivers at:
  https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-February/115278.html

I have made a patch to fix this previously.
  http://patchwork.ozlabs.org/patch/319624/

This is another respin with the implementation suggested by Rob Herring.

Kevin Hao (2):
  Revert "OF: base: match each node compatible against all given matches
    first"
  of: search the best compatible match first in __of_match_node()

 drivers/of/base.c | 88 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 34 deletions(-)

-- 
1.8.5.3
