Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3BB86DDEF0
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 03:33:26 +1100 (EST)
In-Reply-To: <020e01c73733$0932c350$020120ac@Jocke>
References: <020e01c73733$0932c350$020120ac@Jocke>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2748B88F-154A-4C76-B782-EC4556D8A094@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: latest linux git doesn't compile ucc_geth_phy.c and ucc_geth.c
Date: Mon, 15 Jan 2007 10:33:43 -0600
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I know.

Get a Timur to send them to akpm, CC jgarzik.  That should be a  
better path.

- k


On Jan 13, 2007, at 10:51 AM, Joakim Tjernlund wrote:

>> -----Original Message-----
>> From:
>> linuxppc-dev-bounces+joakim.tjernlund=transmode.se@ozlabs.org
>> [mailto:linuxppc-dev-bounces+joakim.tjernlund=transmode.se@ozl
>> abs.org] On Behalf Of Joakim Tjernlund
>> Sent: den 5 januari 2007 14:20
>> To: 'Kumar Gala'
>> Cc: 'linuxppc-dev'
>> Subject: RE: latest linux git doesn't compile ucc_geth_phy.c
>> and ucc_geth.c
>>
>>> -----Original Message-----
>>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>>> Sent: den 18 december 2006 19:44
>>> To: Timur Tabi
>>> Cc: Joakim Tjernlund; 'linuxppc-dev'
>>> Subject: Re: latest linux git doesn't compile ucc_geth_phy.c
>>> and ucc_geth.c
>>>
>>>
>>> On Dec 18, 2006, at 9:56 AM, Timur Tabi wrote:
>>>
>>>> Joakim Tjernlund wrote:
>>>>
>>>>>> I've tested these on an 8360EMDS, and Kumar has reviewed and
>>>>>> signed off on the
>>>>>> code, so I think they're good.  Please let me know if
>> they're not.
>>>>>
>>>>> Has these been sent upstream yet? Didn't se them in
>> linux tree as
>>>>> of now.
>>>>
>>>> I posted the patches to the linuxppc-dev and netdev mailing
>>> lists.
>>>> At this
>>>> point, these patches are at the whim of Paul M. and/or
>> Jeff G. for
>>>> merging.
>>>> Since the holidays are upon us, I'm not surprised that
>> things are
>>>> taking longer
>>>> than normal.
>>>
>>> There really at the whim of Jeff G. since they are
>> completely driver
>>> related.  I pinged Jeff G. to hopefully pick them up and push them
>>> for 2.6.20.
>>
>> I do think these has been forgotten.
>>
>>  Jocke
>
> These are still not in linus tree. Tried to ping Jeff/netdev a  
> couple of times
> but nothing yet. Can't you push these via Paulus tree instead as  
> Jeff seems to
> be doing other things?
>
> The actual patches are here:
> http://ozlabs.org/pipermail/linuxppc-dev/2006-December/029247.html
> http://ozlabs.org/pipermail/linuxppc-dev/2006-December/029248.html
>
>  Jocke
