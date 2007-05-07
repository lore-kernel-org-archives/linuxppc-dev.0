Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2F6E7DDF1F
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 07:59:30 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l47LxQ4d014864
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 14:59:27 -0700 (MST)
In-Reply-To: <463F9FC0.6030000@freescale.com>
References: <20070507182957.GK26920@ld0162-tx32.am.freescale.net>
	<183F76F8-BC1B-4EB6-9C3A-4F0FFA7B3BB8@freescale.com>
	<463F9FC0.6030000@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8B4684BD-79AD-489E-8A1D-9C9DB58E80D6@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH 12/13] gianfar: Add flags for magic packet and MDIO.
Date: Mon, 7 May 2007 16:59:35 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 7, 2007, at 16:53, Scott Wood wrote:

> Andy Fleming wrote:
>> Hrm.  I don't think this is a good way to go.  The DEV* flags are  
>> all  features right now, rather than configuration settings.  It  
>> seems  like this is a stop-gap solution for until more robust  
>> detection of  the ability to power down the interface.  I can  
>> understand that a  full solution might be beyond the ambitions of  
>> this first set of  patches, but I'd prefer if we didn't pollute  
>> gianfar's device flags  space with a flag that we should aim at  
>> removing eventually.
>
> I'd rather "pollute" an existing flags with something that can be  
> removed (and the bit reused, if you're concerned about that) later,  
> than add a completely new field to accomplish the same thing.

Well, I'd rather neither.  :)

>
> And like the other DEV flags, it's an attribute of the device as it  
> exists in the system.

None of those flags are attributes of the system.  They are all flags  
that indicate features of the device, independent of the system.  The  
two board flags are system flags, but they are fully deprecated.   
They only exist in arch/ppc, and the driver never references them.

Andy
