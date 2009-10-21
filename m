Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C1C6BB7B96
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2009 05:01:28 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n9LI1P5Z006569
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2009 11:01:25 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n9LI4Toe003283
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2009 13:04:29 -0500 (CDT)
Message-ID: <4ADF4C8E.3030209@freescale.com>
Date: Wed, 21 Oct 2009 13:01:50 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v3 2/3] powerpc/fsl: 85xx: document cache-sram
References: <1256129459-10685-1-git-send-email-vivek.mahajan@freescale.com>	<1256129459-10685-2-git-send-email-vivek.mahajan@freescale.com>
	<20091021175012.ED29819F73@gemini.denx.de>
In-Reply-To: <20091021175012.ED29819F73@gemini.denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	Vivek Mahajan <vivek.mahajan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wolfgang Denk wrote:
> Dear Vivek Mahajan,
> 
> In message <1256129459-10685-2-git-send-email-vivek.mahajan@freescale.com> you wrote:
>> Adds documentation for Freescale's QorIQ based cache-sram as under:-
>>
>> * How to enable it from a low level driver
>> * How to set its size
> ...
>> +The size of the above cache SRAM memory window is passed via the
>> +kernel command line as <cache-sram-size=....>
> 
> Would it not make more sense to configure this property through the
> device tree? 

The device tree describes the hardware.  It is not a kernel config tree.

-Scott
