Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CE7F6DDE3A
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 05:45:23 +1000 (EST)
Message-ID: <46E59E9E.30707@freescale.com>
Date: Mon, 10 Sep 2007 14:44:30 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 02/10] cpm2: Fix off-by-one error in setbrg().
References: <20070905192910.GA32462@ld0162-tx32.am.freescale.net>
	<EDF5D1CF-E423-449F-A435-9BD044206F4F@kernel.crashing.org>
In-Reply-To: <EDF5D1CF-E423-449F-A435-9BD044206F4F@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Sep 5, 2007, at 2:29 PM, Scott Wood wrote:
> 
>> The hardware adds one to the BRG value to get the divider, so it must
>> be subtracted by software.  Without this patch, characters will 
>> occasionally
>> be corrupted.
>>
>> Signed-off-by: Scott Wood <scottwood@freescale.com>
>> ---
>>  arch/powerpc/sysdev/cpm2_common.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> What was this patch against?
> 
> I ended up applying it by hand for 2.6.23 since its fixing a bug..  But, 
> I'm wondering if there was a base set of changes this patchset was against?

It was against head-of-your-tree as of the time I sent it.

-Scott
