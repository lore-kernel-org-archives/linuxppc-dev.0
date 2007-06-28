Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EDDF4DDF0F
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 19:23:28 +1000 (EST)
In-Reply-To: <20070628002438.GB15298@localhost.localdomain>
References: <11829333481420-git-send-email-wei.zhang@freescale.com>
	<11829333481977-git-send-email-wei.zhang@freescale.com>
	<20070628002438.GB15298@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f297007fcff5c94d8a91a6739f112910@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/5 v2] Add the explanation and a sample of RapidIO DTS
	sector to the document of booting-without-of.txt file.
Date: Thu, 28 Jun 2007 11:23:22 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> +   k) RapidIO
>> +
>> +   Required properties:
>
> Should probably recommend a name for the node here, as well.  "srio" I
> guess, from the example below.

I would prefer "rapidio", being more generic and more
readable.  What would parallel RapidIO be, "prio"?  No
thanks :-)


Segher
