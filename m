Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 447F6DDDD8
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 05:39:57 +1100 (EST)
Message-ID: <48FE21EA.2090509@freescale.com>
Date: Tue, 21 Oct 2008 13:39:38 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc/83xx: add DS1339 RTC support for MPC8349E-mITX
	boards
References: <20081017185659.GA30008@oksana.dev.rtsoft.ru>
	<20081021182344.GA22232@ld0162-tx32.am.freescale.net>
	<4E174FEE-CFF8-4E27-BD6B-4B0557A4E0E2@kernel.crashing.org>
In-Reply-To: <4E174FEE-CFF8-4E27-BD6B-4B0557A4E0E2@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Oct 21, 2008, at 1:23 PM, Scott Wood wrote:
>> Why are we adding more device_types?
> 
> I think the 'rtc' device_type is legacy from OF.

Yes, and it advertises a run-time service that we do not and cannot 
support.  We should not have it in flat trees.

-Scott
