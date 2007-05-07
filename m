Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 75D07DDE39
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 07:53:11 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l47Lr6m9005581
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 14:53:06 -0700 (MST)
Message-ID: <463F9FC0.6030000@freescale.com>
Date: Mon, 07 May 2007 16:53:04 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH 12/13] gianfar: Add flags for magic packet and MDIO.
References: <20070507182957.GK26920@ld0162-tx32.am.freescale.net>
	<183F76F8-BC1B-4EB6-9C3A-4F0FFA7B3BB8@freescale.com>
In-Reply-To: <183F76F8-BC1B-4EB6-9C3A-4F0FFA7B3BB8@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andy Fleming wrote:
> Hrm.  I don't think this is a good way to go.  The DEV* flags are all  
> features right now, rather than configuration settings.  It seems  like 
> this is a stop-gap solution for until more robust detection of  the 
> ability to power down the interface.  I can understand that a  full 
> solution might be beyond the ambitions of this first set of  patches, 
> but I'd prefer if we didn't pollute gianfar's device flags  space with a 
> flag that we should aim at removing eventually.

I'd rather "pollute" an existing flags with something that can be 
removed (and the bit reused, if you're concerned about that) later, than 
add a completely new field to accomplish the same thing.

And like the other DEV flags, it's an attribute of the device as it 
exists in the system.

-Scott
