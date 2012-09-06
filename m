Return-Path: <enrico.scholz@sigma-chemnitz.de>
Received: from mail.cvg.de (mail.cvg.de [62.153.82.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.cvg.de", Issuer "SIGMA Chemnitz Server CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4AFAD2C03D8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2012 00:32:28 +1000 (EST)
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: Chen Peter-B29397 <B29397@freescale.com>
Subject: Re: [PATCH] usb: gadget: fsl_udc_core: remove mapped flag
References: <1346779499-6085-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
 <F281D0F91ED19E4D8E63A7504E8A649803C67DB9@039-SN2MPN1-023.039d.mgd.msft.net>
Date: Thu, 06 Sep 2012 16:32:28 +0200
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803C67DB9@039-SN2MPN1-023.039d.mgd.msft.net>
 (Chen Peter-B's message of "Wed, 5 Sep 2012 02:17:05 +0000")
Message-ID: <lya9x31atf.fsf@ensc-virt.intern.sigma-chemnitz.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>, "balbi@ti.com" <balbi@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Chen Peter-B29397 <B29397@freescale.com> writes:

> If the class driver has already mapped this address, the req->req.dma is not
> DMA_ADDR_INVALID either, in this case, the dma_sync_single_for_cpu is
> enough.

ok; forget the patch then.


Thanks
Enrico
