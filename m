Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B971EDDDFA
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 01:28:28 +1000 (EST)
In-Reply-To: <1178706570.3453.63.camel@zod.rchland.ibm.com>
References: <cbcd7823ea9b0f17f998670915719a05@kernel.crashing.org>
	<AF0367BA48C55940A43CCF08DF35553C012AA296@az33exm24.fsl.freescale.net>
	<20070509004948.GB4198@localhost.localdomain>
	<1178706570.3453.63.camel@zod.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0f60e44e6c7848e5eee8c82c0f2bfaec@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2 6/7] Holly DTS
Date: Wed, 9 May 2007 17:28:18 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Loeliger Jon-LOELIGER <jdl@Freescale.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> Other dts'es are similar. Could be nice
>>>>> to have a comment next to it if that's the case.
>>>>
>>>> Yeah.  There's also this ?? syntax now I believe.
>>>
>>> Not quite yet.
>>
>> Yes, the idea was raised, but discussion kind of petered out and
>> nobody (read: me) got around to implementing it.
>
> What exactly did this ?? syntax imply?  I must have missed that thread.

A property in a DTS file can use that to say
the property should have a value, but it will
be filled in by the bootwrapper instead (memory
address/size, or network MAC address, for
instance).  Presumably the kernel parser would
complain when it sees the this-is-still-undefined
marker.

The original proposal specified the length of
the property value IIRC, but that isn't necessary
anymore.


Segher
