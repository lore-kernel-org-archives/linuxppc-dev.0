Return-Path: <auke-jan.h.kok@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by ozlabs.org (Postfix) with ESMTP id 110EADDED0
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 02:38:14 +1000 (EST)
Message-ID: <46AE13D0.7060902@intel.com>
Date: Mon, 30 Jul 2007 09:37:36 -0700
From: "Kok, Auke" <auke-jan.h.kok@intel.com>
MIME-Version: 1.0
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [PATCH 3/4][RFC] ehea: LRO support
References: <200707301724.49829.ossthema@de.ibm.com>
In-Reply-To: <200707301724.49829.ossthema@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Andrew Gallatin <gallatin@myri.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jan-Bernd Themann wrote:
> Added LRO support using the "SKB aggregate" interface
> 
> Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
> 
> ---
>  drivers/net/ehea/ehea.h         |    9 ++++-
>  drivers/net/ehea/ehea_ethtool.c |   15 +++++++
>  drivers/net/ehea/ehea_main.c    |   82 +++++++++++++++++++++++++++++++++++---
>  3 files changed, 98 insertions(+), 8 deletions(-)

<snip>

> +module_param(use_lro, int, 0);
> +module_param(lro_max_aggr, int, 0);

this should obviously (and Stephen H. probably agrees) be implemented in ethtool 
instead, and opens up the question as to what changes we need to add to ethtool. ..

Auke
