Message-ID: <3C6B6FE9.6030406@pacbell.net>
Date: Thu, 14 Feb 2002 08:06:01 +0000
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: Stefan Roese <stefan.roese@esd-electronics.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc4xx_serial.c?
References: <EFEAIMDCOOOHIEPHDNFJAEOCDKAA.stefan.roese@esd-electronics.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stefan Roese wrote:
>>Is arch/ppc/kernel/ppc4xx_serial.c of any relevance any more?  It
>>doesn't include any code unless CONFIG_DEBUG_BRINGUP is defined, and
>>it doesn't look like it would compile, let alone be called, if it was
>>defined.
>>
>
> That was also my impression. It seems, that this file could be removed.
>
> Stefan.
>
>
>
>
>

remnance from the intial release.

--armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
