Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 86A40679E6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 00:30:17 +1000 (EST)
In-Reply-To: <c2628642aad8b8107d0e9db84535ea0c@onz.com>
References: <c2628642aad8b8107d0e9db84535ea0c@onz.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <282db6371fad3a0321c673a6b0b524ef@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 15 Jun 2005 09:30:09 -0500
To: "Allen Curtis" <acurtis@onz.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: RFC: cpm2_devices.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 14, 2005, at 11:41 PM, Allen Curtis wrote:

>>>> I've also included our version of this patch for commentary. Did you
>>>> see a
>>>> need for the following to actually be devices? (DMA, CPM, SI1,
> SIC2).
>>>>
>>> The good thing about them actually being devices is that you can find
>>> them and the IO resources had already been remapped. You don't need a
>>> device driver for them but they are resources used by other device
>>> drivers.
>>
>> Not sure I follow.  The IO resources are not mapped by anything until
>> some piece of code does an explicit ioremap().  How do you plan on
>> finding them?  I've got now issue adding them, I just want to
>> understand how you see us using them.  A simple code example might be
>> helpful.

Allen, you haven't addressed my question.

- kumar
