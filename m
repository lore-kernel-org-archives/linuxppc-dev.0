Date: Wed, 26 Dec 2001 13:25:54 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200112262125.fBQLPs418260@xdr.com>
To: wd@denx.de
Subject: Re: 8260 + cache/dma issues
Cc: linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>> I'm running into repeated problems related to cache problems on
>> ppc 8260 based hardware. The kernel is based on Montevista's 2.4.2.
>> The same problem keeps coming up again and again. Here it is:
>
>Which mask revision are you using?
>
>Are you running in 60x bus mode, or in 8260 bus mode?
>
>Is ther L2 cache on your board?
>
>Wolfgang Denk

The mask is A.1.

It is running in 60x bus mode.

There is no L2 cache.

-Dave

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
