Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D7152DDEE2
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 07:21:08 +1000 (EST)
Message-ID: <4828B4BB.2020403@freescale.com>
Date: Mon, 12 May 2008 16:20:59 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: cbouatmailru@gmail.com
Subject: Re: [PATCH 1/3] [WATCHDOG] mpc83xx_wdt: add support for MPC86xx	CPUs
References: <20080512185206.GA25818@polina.dev.rtsoft.ru>
	<64629276-8337-4FFE-B3E1-306678BF179D@kernel.crashing.org>
	<20080512205303.GA14198@zarina> <4828AFBD.1040501@freescale.com>
	<4828B012.9090805@freescale.com> <20080512211856.GA21532@zarina>
In-Reply-To: <20080512211856.GA21532@zarina>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Wim Van Sebroeck <wim@iguana.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> On Mon, May 12, 2008 at 04:01:06PM -0500, Timur Tabi wrote:
>> Scott Wood wrote:
>>
>>> It avoids confusion.  I vote for renaming.
>> Me too.  How about fsl_wdt.c?
> 
> fsl_wdt sounds too generic, I think it would conflict with
> at least booke_wdt.c.. no?

Yeah, that makes sense.  What's the difference between booke_wdt.c and 
mpc83xx_wdt.c?
