Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 78CF8DDF30
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 09:59:46 +1000 (EST)
Message-Id: <FF811ACE-DCE5-445B-8916-A6BCE691DE8D@freescale.com>
From: Andy Fleming <afleming@freescale.com>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <481B5870.2010000@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH v2.6.26] powerpc: Fix a bunch of sparse warnings in the
	qe_lib
Date: Fri, 2 May 2008 18:59:37 -0500
References: <1209751415-25612-1-git-send-email-afleming@freescale.com>
	<481B5870.2010000@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Tabi Timur <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 2, 2008, at 13:07, Scott Wood wrote:

> Andy Fleming wrote:
>> +	struct qe_iram __iomem	iram;		/* I-RAM */
>> +	struct qe_ic_regs __iomem ic;		/* Interrupt Controller */
>> +	struct cp_qe __iomem	cp;		/* Communications Processor */
>> +	struct qe_mux __iomem	qmx;		/* QE Multiplexer */
>> +	struct qe_timers __iomem qet;		/* QE Timers */
>> +	struct spi __iomem	spi[0x2];	/* spi */
>> +	struct mcc __iomem	mcc;		/* mcc */
>> +	struct qe_brg __iomem	brg;		/* brg */
>> +	struct usb_ctlr __iomem	usb;		/* USB */
>> +	struct si1 __iomem	si1;		/* SI */
>
> Why not just set __iomem on qe_immap references?

Does that work?  I'm not quite clear on how the scope for __iomem works.

I can definitely do that, though.
