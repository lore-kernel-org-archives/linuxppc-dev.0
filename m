Return-Path: <yc_chen@aspeedtech.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vV2jj1j8WzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 18:27:05 +1100 (AEDT)
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com
 [211.20.114.71]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vV2jh4FKdz9s7R
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 18:27:04 +1100 (AEDT)
Received: from twspam01.aspeedtech.com (localhost [127.0.0.2])
 by twspam01.aspeedtech.com with ESMTP id v1O7KRZM057211
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 15:20:27 +0800 (CST)
 (envelope-from yc_chen@aspeedtech.com)
From: YC Chen <yc_chen@aspeedtech.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: "airlied@redhat.com" <airlied@redhat.com>, "eich@suse.come"
 <eich@suse.come>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, "YC
 Chen" <yc_chen@aspeedtech.com>
Subject: RE: [PATCH 08/12] drm/ast: Factor mmc_test code in POST code
Date: Fri, 24 Feb 2017 07:07:51 +0000
Message-ID: <5763f91f99f14025aa05601557a23891@TWMBX01.aspeed.com>
References: <20170223225357.9572-1-benh@kernel.crashing.org>
 <20170223225357.9572-8-benh@kernel.crashing.org>
In-Reply-To: <20170223225357.9572-8-benh@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tested-by: Y.C. Chen <yc_chen@aspeedtech.com>

-----Original Message-----
From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]=20
Sent: Friday, February 24, 2017 6:54 AM
To: dri-devel@lists.freedesktop.org
Cc: YC Chen <yc_chen@aspeedtech.com>; airlied@redhat.com; eich@suse.come; l=
inuxppc-dev@ozlabs.org
Subject: [PATCH 08/12] drm/ast: Factor mmc_test code in POST code

There's a some duplication for what's essentially copies of two loops, so f=
actor it. The upcoming AST2500 POST code adds more of them. Also cleanup re=
turn types for the test functions, most of them return a boolean, some retu=
rn a u32.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
