Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 79BA6DDEB6
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 08:40:00 +1000 (EST)
Message-ID: <469E96B8.3010708@garzik.org>
Date: Wed, 18 Jul 2007 18:39:52 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Thomas Klein <osstklei@de.ibm.com>
Subject: Re: [PATCH] eHEA: Fix bonding support
References: <200707181734.09278.osstklei@de.ibm.com>
In-Reply-To: <200707181734.09278.osstklei@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	Stefan Roscher <ossrosch@linux.vnet.ibm.com>,
	linux-ppc <linuxppc-dev@ozlabs.org>,
	Jan-Bernd Themann <ossthema@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thomas Klein wrote:
> The driver didn't allow an interface's MAC address to be modified if the
> respective interface wasn't setup - a failing Hcall was the result. Thus
> bonding wasn't usable. The fix moves the failing Hcall which was registering
> a MAC address for the reception of BC packets in firmware from the port up
> and down functions to the port resources setup functions. Additionally the
> missing update of the last_rx member of the netdev structure was added.
> 
> Signed-off-by: Thomas Klein <tklein@de.ibm.com>
> 
> ---
>  drivers/net/ehea/ehea.h      |    2 +-
>  drivers/net/ehea/ehea_main.c |   37 +++++++++++++++++++------------------
>  2 files changed, 20 insertions(+), 19 deletions(-)

applied
