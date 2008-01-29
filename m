Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 678F8DDE22
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jan 2008 09:33:25 +1100 (EST)
In-Reply-To: <000601c85fc5$41e48330$6405a8c0@absolut>
References: <mailman.1.1201309203.24413.linuxppc-embedded@ozlabs.org>
	<000601c85fc5$41e48330$6405a8c0@absolut>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D71D9F25-4724-487E-AD07-E848B4608B97@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: SET_NETDEV_DEV -> 83xx HDLC Driver??
Date: Tue, 29 Jan 2008 16:32:49 -0600
To: rmcguire@videopresence.com
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jan 25, 2008, at 20:43, Russell McGuire wrote:

> All,
>
> I am partly done porting a combination of the 83xx ATM driver and  
> dscc4 HDLC
> driver into a 83xx HDLC driver.
>
> However, encounter a call I don't truly understand.
>
> SET_NETDEV_DEV(dev, pointer_to_some_handle);
>
> I can see plenty of examples of this registering some kind of PCI  
> device
> handle, however in this case I am not using a PCI device. So what  
> should the
> pointer be? Or can this call be ignored, and if so what are the
> consequences?
>
> I see the some of the Freescale Ethernet devices don't use this call.
>
> Anyway, can somebody shed some light on if I am going to need this,  
> or a way
> to get it to work, without creating a PCI device?


Look at gianfar.c (which uses a platform_device) or ucc_geth (which  
uses an of_device).  Which freescale devices don't use that call?   
We'll fix them.

Andy
