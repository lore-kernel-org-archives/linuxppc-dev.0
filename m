Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DA099DDF2A
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 05:25:40 +1100 (EST)
Message-ID: <477D28D3.3000102@freescale.com>
Date: Thu, 03 Jan 2008 12:26:27 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2] ucc_uart: add support for Freescale QUICCEngine UART
References: <11970458703666-git-send-email-timur@freescale.com>
	<20071226165816.GB11449@localhost.localdomain>
	<4776C5EE.70004@freescale.com>
	<20080102181226.GA4486@loki.buserror.net>
In-Reply-To: <20080102181226.GA4486@loki.buserror.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:

>>>> +static struct of_platform_driver ucc_uart_of_driver = {
>>>> +	.owner  	= THIS_MODULE,
>>>> +	.name   	= "ucc_uart",
>>> Maybe better fsl,ucc_uart?
> 
> fsl,qe-uart is defined by Documentation/powerpc/booting-without-of.txt.

Wait, I'm confused.  What does the of_platform_driver.name string have to do 
with the compatible field in the device tree?  Like I said earlier, I'm just 
following the example of the other QE device drivers.  If you want me to break 
that example, I'm going to need an explanation why the other drivers do it wrong.


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
