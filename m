Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6FD02DDE1C
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 08:00:09 +1000 (EST)
Message-ID: <469BEA5F.5050508@garzik.org>
Date: Mon, 16 Jul 2007 17:59:59 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Thomas Klein <osstklei@de.ibm.com>
Subject: Re: [PATCH 1/1] eHEA: Introducing support vor DLPAR memory add
References: <200707111632.00235.osstklei@de.ibm.com>
In-Reply-To: <200707111632.00235.osstklei@de.ibm.com>
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
> This patch adds support for DLPAR memory add to the eHEA driver. To detect
> whether memory was added the driver uses its own memory mapping table and
> checks for kernel addresses whether they're located in already known memory
> sections. If not the function ehea_rereg_mrs() is triggered which performs
> a rebuild of the mapping table and a re-registration of the global memory
> region.
> 
> Signed-off-by: Thomas Klein <tklein@de.ibm.com>
> ---
> 
>  drivers/net/ehea/ehea.h      |   23 +++++--
>  drivers/net/ehea/ehea_main.c |  144 +++++++++++++++++++++++++++++++++++----
>  drivers/net/ehea/ehea_phyp.h |    3 +
>  drivers/net/ehea/ehea_qmr.c  |  156 ++++++++++++++++++++++++++++++------------
>  drivers/net/ehea/ehea_qmr.h  |   14 +++-
>  5 files changed, 275 insertions(+), 65 deletions(-)

applied
