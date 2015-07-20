Return-Path: <k.opasiak@samsung.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A9F61A0A20
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 00:53:31 +1000 (AEST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NRS000DHJK9TX60@mailout1.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Mon, 20 Jul 2015 15:43:21 +0100 (BST)
Message-id: <55AD0907.8090605@samsung.com>
Date: Mon, 20 Jul 2015 16:43:19 +0200
From: Krzysztof Opasiak <k.opasiak@samsung.com>
MIME-version: 1.0
To: Robert Baldyga <r.baldyga@samsung.com>, gregkh@linuxfoundation.org,
 balbi@ti.com
Cc: Peter.Chen@freescale.com, johnyoun@synopsys.com, dahlmann.thomas@arcor.de,
 nicolas.ferre@atmel.com, cernekee@gmail.com, leoli@freescale.com,
 daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
 michal.simek@xilinx.com, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-geode@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 andrzej.p@samsung.com, m.szyprowski@samsung.com
Subject: Re: [PATCH v3 01/46] usb: gadget: encapsulate endpoint claiming
 mechanism
References: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
 <1436941953-1327-2-git-send-email-r.baldyga@samsung.com>
In-reply-to: <1436941953-1327-2-git-send-email-r.baldyga@samsung.com>
Content-type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 07/15/2015 08:31 AM, Robert Baldyga wrote:
> So far it was necessary for usb functions to set ep->driver_data in
> endpoint obtained from autoconfig to non-null value, to indicate that
> endpoint is claimed by function (in autoconfig it was checked if endpoint
> has set this field to non-null value, and if it has, it was assumed that
> it is claimed). It could cause bugs becouse if some function doesn't

	s/becouse/because

Best regards,
-- 
Krzysztof Opasiak
Samsung R&D Institute Poland
Samsung Electronics
