Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 63974DDE21
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 19:05:31 +1000 (EST)
In-Reply-To: <20070613084023.GA28629@aepfle.de>
References: <20070612181825.730300780@am.sony.com>>
	<466EEC01.6080807@am.sony.com>
	<f7c4ca74d3e2031e01264f31f09e515a@kernel.crashing.org>
	<20070613084023.GA28629@aepfle.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0502b4de346bce374f98c49a99be50c1@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 29/30] PS3: Device tree source.
Date: Wed, 13 Jun 2007 11:05:24 +0200
To: Olaf Hering <olaf@aepfle.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +/ {
>>> +	model = "PS3 Game Console";
>>
>> model = "sony,some-model-number" or similar
>>
>>> +	compatible = "PS3";
>>
>> name = "sony,ps3"
>
> Both are wrong.
>
> Stick to the values used right now.
> Which is 'PS3PF'

It should include "sony,", in the "name" property at least.

"model" same as "name" cannot make sense either.

Please read up on what those properties mean exactly.

It won't matter too much for Linux, but if you have a
chance too make it right for a new port, why fail to
do so?


Segher
