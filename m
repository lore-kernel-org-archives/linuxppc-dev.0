Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7264ADE081
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 07:04:53 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m89L4lkH019445
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Sep 2008 14:04:47 -0700 (MST)
Message-ID: <48C6E4EC.3010004@freescale.com>
Date: Tue, 09 Sep 2008 16:04:44 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] Pass actual dev ptr to dma_* in ucc and cpm_uart serial
References: <1220901653-12812-1-git-send-email-becky.bruce@freescale.com>	
	<48C58359.5060208@freescale.com>
	<ed82fe3e0809091125y77973b83vce52e044f329030e@mail.gmail.com>
In-Reply-To: <ed82fe3e0809091125y77973b83vce52e044f329030e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> On Mon, Sep 8, 2008 at 2:56 PM, Scott Wood <scottwood@freescale.com> wrote:
> 
>> This patch doesn't change that for cpm2, since port.dev is never
>> initialized. :-P
> 
> I don't initialize port->dev in the UCC UART driver, 

Yes you do -- check line 1403.

-Scott
