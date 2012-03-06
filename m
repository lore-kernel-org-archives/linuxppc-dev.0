Return-Path: <greg@kroah.com>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0058DB6FA1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 01:45:04 +1100 (EST)
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 51BF620912
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 09:45:00 -0500 (EST)
Date: Tue, 6 Mar 2012 06:32:57 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Subject: Re: [PATCH 1/9] pci_ids: Add device ID for IBM PCI-X bridge
Message-ID: <20120306143257.GA23303@kroah.com>
References: <1331024707-15891-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331024707-15891-1-git-send-email-chenhui.zhao@freescale.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 06, 2012 at 05:05:07PM +0800, Zhao Chenhui wrote:
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> ---
>  include/linux/pci_ids.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 31d77af..8f026c0 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -484,6 +484,7 @@
>  #define PCI_DEVICE_ID_IBM_ICOM_V2_ONE_PORT_RVX_ONE_PORT_MDM	0x0251
>  #define PCI_DEVICE_ID_IBM_ICOM_V2_ONE_PORT_RVX_ONE_PORT_MDM_PCIE 0x0361
>  #define PCI_DEVICE_ID_IBM_ICOM_FOUR_PORT_MODEL	0x252
> +#define PCI_DEVICE_ID_IBM_PCIX_BRIDGE	0x01a7

Did you read the comment at the top of this file?
