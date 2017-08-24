Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdVSy1drpzDrJv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 02:42:25 +1000 (AEST)
Date: Thu, 24 Aug 2017 09:42:20 -0700 (PDT)
Message-Id: <20170824.094220.1750290899777462105.davem@davemloft.net>
To: madalin.bucur@nxp.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Add RSS to DPAA 1.x Ethernet driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <1503559708-13405-1-git-send-email-madalin.bucur@nxp.com>
References: <1503559708-13405-1-git-send-email-madalin.bucur@nxp.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Madalin Bucur <madalin.bucur@nxp.com>
Date: Thu, 24 Aug 2017 10:28:21 +0300

> This patch set introduces Receive Side Scaling for the DPAA Ethernet
> driver. Documentation is updated with details related to the new
> feature and limitations that apply.
> Added also a small fix.
> 
> v2: removed a C++ style comment
> v3: move struct fman to header file to avoid exporting a function

Series applied, thanks.
