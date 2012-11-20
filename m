Return-Path: <davidb@codeaurora.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
 [199.106.114.251])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "wolverine02.qualcomm.com",
 Issuer "VeriSign Class 3 Secure Server CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7C7522C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2012 04:06:29 +1100 (EST)
Date: Tue, 20 Nov 2012 09:06:25 -0800
From: David Brown <davidb@codeaurora.org>
To: Bill Pemberton <wfp5p@virginia.edu>
Subject: Re: [PATCH 429/493] tty: remove use of __devexit
Message-ID: <20121120170624.GF21706@codeaurora.org>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-429-git-send-email-wfp5p@virginia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353349642-3677-429-git-send-email-wfp5p@virginia.edu>
Cc: nios2-dev@sopc.et.ntust.edu.tw, Jiri Slaby <jirislaby@gmail.com>,
 gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
 uclinux-dist-devel@blackfin.uclinux.org, Tony Prisk <linux@prisktech.co.nz>,
 Bryan Huntsman <bryanh@codeaurora.org>, linux-serial@vger.kernel.org,
 Lucas Tavares <lucaskt@linux.vnet.ibm.com>, sparclinux@vger.kernel.org,
 Daniel Walker <dwalker@fifo99.com>, Tobias Klauser <tklauser@distanz.ch>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 19, 2012 at 01:26:18PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit is no
> longer needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> ---
>  drivers/tty/serial/msm_serial.c             |  2 +-
>  drivers/tty/serial/msm_serial_hs.c          |  2 +-

Acked-by: David Brown <davidb@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
