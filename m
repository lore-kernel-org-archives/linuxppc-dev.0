Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CDD66DDD0A
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 22:08:03 +1000 (EST)
In-Reply-To: <3198C3F2-91CE-4AF6-822B-5BA2820458C7@kernel.crashing.org>
References: <20070709214853.GA29912@ld0162-tx32.am.freescale.net>
	<1184705168.24473.32.camel@ld0161-tx32>
	<469D3F60.8000401@freescale.com> <E1IAvmA-00062M-F4@jdl.com>
	<469D487D.1020900@freescale.com>
	<AADEBC41-7CB4-4B72-89EC-5C71137E2A5B@kernel.crashing.org>
	<3198C3F2-91CE-4AF6-822B-5BA2820458C7@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F803407D-9A94-4662-8008-6ACF70837BDD@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2] Allow exec on 32-bit from readable, non-exec pages,
	with a warning.
Date: Wed, 18 Jul 2007 14:07:17 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Jon Loeliger <jdl@jdl.com>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> A:  They haven't been posted yet.
>>>>
>>>> Q:  How do we know Segher has new patches?
>>>
>>> He sent it to me to test, and I told him it worked...
>>
>> And I sent it to the list hours later, over a week ago.
>
> Can someone send a ozlabs linuxppc list link or patchworks to the  
> "new" patch.

<http://ozlabs.org/pipermail/linuxppc-dev/2007-July/039076.html>
is Johannes' ack.
It seems ozlabs ate the original, will resend.


Segher
