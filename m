Return-Path: <auke-jan.h.kok@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by ozlabs.org (Postfix) with ESMTP id 5E8A8DDE11
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Aug 2007 06:29:39 +1000 (EST)
Message-ID: <46B39030.7030009@intel.com>
Date: Fri, 03 Aug 2007 13:29:36 -0700
From: "Kok, Auke" <auke-jan.h.kok@intel.com>
MIME-Version: 1.0
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [PATCH] lro: eHEA example how to use LRO
References: <200708031441.26841.ossthema@de.ibm.com>
In-Reply-To: <200708031441.26841.ossthema@de.ibm.com>
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
> This patch shows how the generic LRO interface is used for SKB mode
> 
> Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
> 
> ---
>  drivers/net/Kconfig             |    1 +
>  drivers/net/ehea/ehea.h         |    9 ++++-
>  drivers/net/ehea/ehea_ethtool.c |   15 +++++++
>  drivers/net/ehea/ehea_main.c    |   84 +++++++++++++++++++++++++++++++++++---
>  4 files changed, 101 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index f8a602c..fec4004 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig

<snip>

> +module_param(use_lro, int, 0);

Have you looked at my generic lro get/set patch that I posted this week? this 
adds a useless module parameter while ethtool has all the structure already to 
accomodate setting lro on/off.

Auke
