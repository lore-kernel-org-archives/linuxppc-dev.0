Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xh7Zw6HMZzDqGG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 09:41:43 +1000 (AEST)
Date: Mon, 28 Aug 2017 16:41:38 -0700 (PDT)
Message-Id: <20170828.164138.1780653981574209650.davem@davemloft.net>
To: madalin.bucur@nxp.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] Add RSS to DPAA 1.x Ethernet driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <1503839623-3906-1-git-send-email-madalin.bucur@nxp.com>
References: <1503839623-3906-1-git-send-email-madalin.bucur@nxp.com>
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
Date: Sun, 27 Aug 2017 16:13:36 +0300

> This patch set introduces Receive Side Scaling for the DPAA Ethernet
> driver. Documentation is updated with details related to the new
> feature and limitations that apply.
> Added also a small fix.
> 
> v2: removed a C++ style comment
> v3: move struct fman to header file to avoid exporting a function
> v4: addressed compilation issues introduced in v3

Series applied, thanks.
