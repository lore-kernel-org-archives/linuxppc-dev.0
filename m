Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EB2BBDDE17
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 06:58:50 +1000 (EST)
Message-ID: <4828AFBD.1040501@freescale.com>
Date: Mon, 12 May 2008 15:59:41 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: cbouatmailru@gmail.com
Subject: Re: [PATCH 1/3] [WATCHDOG] mpc83xx_wdt: add support for MPC86xx CPUs
References: <20080512185206.GA25818@polina.dev.rtsoft.ru>	<64629276-8337-4FFE-B3E1-306678BF179D@kernel.crashing.org>
	<20080512205303.GA14198@zarina>
In-Reply-To: <20080512205303.GA14198@zarina>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Wim Van Sebroeck <wim@iguana.be>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> On Mon, May 12, 2008 at 02:24:20PM -0500, Kumar Gala wrote:
>> we should rename it to mpc8xxx_wdt.c
> 
> I don't see much sense in renaming the files just because the driver
> now supports another line of processors... Do you really want the rename?
> Please repeat if so.
> 

It avoids confusion.  I vote for renaming.

-Scott
