Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F0E35DDE16
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 08:33:34 +1000 (EST)
Message-ID: <469E953A.5090806@garzik.org>
Date: Wed, 18 Jul 2007 18:33:30 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/4] ibmveth: Implement ethtool hooks to enable/disable
	checksum offload
References: <11846854701127-patch-mail.ibm.com>
	<200707171517.l6HFHwf2015030@d03av04.boulder.ibm.com>
In-Reply-To: <200707171517.l6HFHwf2015030@d03av04.boulder.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, rcjenn@linux.vnet.ibm.com,
	santil@linux.vnet.ibm.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Brian King wrote:
> This patch adds the appropriate ethtool hooks to allow for enabling/disabling
> of hypervisor assisted checksum offload for TCP.
> 
> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
> ---
> 
>  linux-2.6-bjking1/drivers/net/ibmveth.c |  120 +++++++++++++++++++++++++++++++-
>  linux-2.6-bjking1/drivers/net/ibmveth.h |    1 
>  2 files changed, 119 insertions(+), 2 deletions(-)

ACK.  As noted in previous email, with this, module option is not needed
