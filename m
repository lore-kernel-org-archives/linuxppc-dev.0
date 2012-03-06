Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 958EAB6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 09:12:38 +1100 (EST)
Date: Tue, 06 Mar 2012 17:08:19 -0500 (EST)
Message-Id: <20120306.170819.2135873666210523674.davem@davemloft.net>
To: dhdang@apm.com
Subject: Re: [PATCH v3 1/2] powerpc/44x: Add new compatible value for EMAC
 node of APM821XX dts file.
From: David Miller <davem@davemloft.net>
In-Reply-To: <1330945062-15760-1-git-send-email-dhdang@apm.com>
References: <1330920224-3006-1-git-send-email-dhdang@apm.com>
 <1330945062-15760-1-git-send-email-dhdang@apm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, netdev@vger.kernel.org,
 sr@denx.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Duc Dang <dhdang@apm.com>
Date: Mon,  5 Mar 2012 17:57:42 +0700

> This compatible value will be used to distinguish some special features of APM821XX EMAC: no half duplex mode support, configuring jumbo frame.
> 
> Signed-off-by: Duc Dang <dhdang@apm.com>

Applied.
