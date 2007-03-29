Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6965BDDEE3
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Mar 2007 22:35:17 +1000 (EST)
Message-ID: <460BB27C.4070006@garzik.org>
Date: Thu, 29 Mar 2007 08:35:08 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [PATCH] ehea: removing unused functionality
References: <200703231718.53668.ossthema@de.ibm.com>
In-Reply-To: <200703231718.53668.ossthema@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jan-Bernd Themann wrote:
> This patch includes:
> - removal of unused fields in structs
> - ethtool statistics cleanup
> - removes unsed functionality from send path
> 
> Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
> ---
> 
> 
> This patch applies on top of the netdev upstream branch for 2.6.22
> 
> 
>  drivers/net/ehea/ehea.h         |   25 ++-------
>  drivers/net/ehea/ehea_ethtool.c |  111 ++++++++++++++--------------------------
>  drivers/net/ehea/ehea_main.c    |   55 +++++++------------
>  drivers/net/ehea/ehea_qmr.h     |    2
>  4 files changed, 69 insertions(+), 124 deletions(-)
> 

applied to #upstream
