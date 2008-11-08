Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3950CDDF21
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Nov 2008 05:21:45 +1100 (EST)
Message-Id: <62D5BA07-1A84-4B22-8363-147815A84120@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20081108175134.GA6010@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 1/2] powerpc: Update QE/CPM2 usb_ctlr structures for USB
	support
Date: Sat, 8 Nov 2008 12:21:35 -0600
References: <20081108175134.GA6010@oksana.dev.rtsoft.ru>
Cc: Greg Kroah-Hartman <greg@kroah.com>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Li Yang <leoli@freescale.com>, linux-usb@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 8, 2008, at 11:51 AM, Anton Vorontsov wrote:

> From: Li Yang <leoli@freescale.com>
>
> Fixes following build error:
>
>  CC      drivers/usb/gadget/fsl_qe_udc.o
> drivers/usb/gadget/fsl_qe_udc.c: In function 'qe_eprx_stall_change':
> drivers/usb/gadget/fsl_qe_udc.c:156: error: 'struct usb_ctlr' has no  
> member named 'usb_usep'
> drivers/usb/gadget/fsl_qe_udc.c:163: error: 'struct usb_ctlr' has no  
> member named 'usb_usep'
> drivers/usb/gadget/fsl_qe_udc.c: In function 'qe_eptx_stall_change':
> drivers/usb/gadget/fsl_qe_udc.c:173: error: 'struct usb_ctlr' has no  
> member named 'usb_usep'
> drivers/usb/gadget/fsl_qe_udc.c:180: error: 'struct usb_ctlr' has no  
> member named 'usb_usep'
> drivers/usb/gadget/fsl_qe_udc.c: In function 'qe_eprx_nack':
> drivers/usb/gadget/fsl_qe_udc.c:201: error: 'struct usb_ctlr' has no  
> member named 'usb_usep'
> drivers/usb/gadget/fsl_qe_udc.c:201: error: 'struct usb_ctlr' has no  
> member named 'usb_usep'
> drivers/usb/gadget/fsl_qe_udc.c: In function 'qe_eprx_normal':
> drivers/usb/gadget/fsl_qe_udc.c:218: error: 'struct usb_ctlr' has no  
> member named 'usb_usep'
> drivers/usb/gadget/fsl_qe_udc.c:218: error: 'struct usb_ctlr' has no  
> member named 'usb_usep'
> drivers/usb/gadget/fsl_qe_udc.c: In function 'qe_ep_reset':
> drivers/usb/gadget/fsl_qe_udc.c:325: error: 'struct usb_ctlr' has no  
> member named 'usb_usep'
> drivers/usb/gadget/fsl_qe_udc.c:342: error: 'struct usb_ctlr' has no  
> member named 'usb_usep'
> drivers/usb/gadget/fsl_qe_udc.c: In function 'qe_ep_register_init':
> drivers/usb/gadget/fsl_qe_udc.c:515: error: 'struct usb_ctlr' has no  
> member named 'usb_usep'
> drivers/usb/gadget/fsl_qe_udc.c: In function 'ch9getstatus':
> drivers/usb/gadget/fsl_qe_udc.c:1981: error: 'struct usb_ctlr' has  
> no member named 'usb_usep'
> make[2]: *** [drivers/usb/gadget/fsl_qe_udc.o] Error 1
>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/include/asm/immap_cpm2.h |    9 +++------
> arch/powerpc/include/asm/immap_qe.h   |    5 +----
> 2 files changed, 4 insertions(+), 10 deletions(-)

applied to merge

- k
