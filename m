Message-ID: <3C69A361.2070103@embeddededge.com>
Date: Tue, 12 Feb 2002 18:21:05 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
Cc: Eric.Oosterhof@radisys.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: I2C module problem on 8260
References: <OFC97C91CA.1E7BB35E-ON88256B5E.007CD94A@radisys.com> <3C69A0EC.2090400@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:



> One of the programming techniques for modules is you must explicitly
> allocate
> all objects subject to DMA such that they are known to be physically
> contiguous
> if necessary.

I should have also mentioned that using these functions also returns
both physical and virtual addresses that you should keep within your
driver so you can avoid calling any function/macro that converts
between physical and virtual addresses.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
