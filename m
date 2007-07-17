Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 448D4DDEBD
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 01:34:08 +1000 (EST)
In-Reply-To: <20070717185229.0f66e227@vitb.ru.mvista.com>
References: <20070717005832.23019.99739.stgit@localhost.localdomain>
	<989B956029373F45A0B8AF0297081890F06271@zch01exm26.fsl.freescale.net>
	<20070717185229.0f66e227@vitb.ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D3CC45D5-5ACD-456D-8F90-60A0C7D71CEF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] USB_DR host support for FSL MPC831x
Date: Tue, 17 Jul 2007 10:34:24 -0500
To: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 17, 2007, at 9:52 AM, Vitaly Bordug wrote:

> On Tue, 17 Jul 2007 20:18:35 +0800
> "Li Yang-r58472" <LeoLi@freescale.com> wrote:
>
>> Hi Vitaly,
>>
>> I believe that your patch is addresses by my patch in 2.6.23 queue:
>> http://www.kernel.org/pub/linux/kernel/people/gregkh/usb/ 
>> 2.6/2.6.22/usb-
>> ehci_fsl-update-for-mpc831x-support.patch
>>
> okay, nm then. I'll revalidate with these 2 patches
> and come up with something ontop if it won't work.
>

FYI, Leo's patches are now in Linus's tree.

- k
