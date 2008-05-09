Return-Path: <becky.bruce@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5B5E1DDE22
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 10:12:23 +1000 (EST)
Message-Id: <2C869E32-30E6-4855-8489-E104C3BB3FAE@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
To: Vitaly Bordug <vitb@gate.crashing.org>
In-Reply-To: <20080508172519.GA12162@gate.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] Delete unused fec_8xx net driver
Date: Thu, 8 May 2008 19:12:10 -0500
References: <Pine.LNX.4.64.0805021320360.24806@monty.am.freescale.net>
	<48208790.5090508@pobox.com>
	<20080508172519.GA12162@gate.crashing.org>
Cc: netdev@vger.kernel.org, jengelh@medozas.de, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 8, 2008, at 12:25 PM, Vitaly Bordug wrote:
> On Tue, May 06, 2008 at 12:30:08PM -0400, Jeff Garzik wrote:
>> Becky Bruce wrote:
>>> This driver has been superseded by fs_enet and is no longer in use.
>>>
>>> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
>>
>> I cannot make an informed judgement on this.
>>
>> ACK, and pass through platform tree, if all platform peeps are happy.
>
> I'll move thins along.
>
>

Great, thanks!

Cheers,
B
