Return-Path: <becky.bruce@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1598FDE10C
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 05:22:09 +1000 (EST)
In-Reply-To: <20080430192030.GA9084@ld0162-tx32.am.freescale.net>
References: <6E2EBEAF-DF1E-4439-91EF-B15EE39CAF61@freescale.com>
	<20080430192030.GA9084@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <151BA0B1-A188-41C7-B2DB-E8D63D15C218@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: drivers/net/fec_8xx config problem
Date: Wed, 30 Apr 2008 14:24:19 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	jengelh@linux01.gwdg.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 30, 2008, at 2:20 PM, Scott Wood wrote:
> On Wed, Apr 30, 2008 at 02:19:21PM -0500, Becky Bruce wrote:
>> I just noticed that the fec_8xx driver is not currently reachable via
>> menuconfig because it depends on 8XX instead of 8xx.
> [snip]
>> Since nobody has noticed this problem, I'm wondering if this driver
>> is still in (infrequent) use, or if it's been superseded and should
>> be removed, or if I'm just completely missing something with respect
>> to the use of "8XX" instead of "8xx".
>
> It's been superseded by drivers/net/fs_enet.

Is there any reason we haven't removed it?  If not, I can push a  
patch to yank it.

Cheers,
B
