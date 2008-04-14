Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A77A4DE8A6
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 00:52:01 +1000 (EST)
Message-Id: <6B2293E0-BE5E-4C2E-9A48-4E91079A7422@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080411173100.GA20439@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 2/2] [POWERPC] UCC nodes cleanup
Date: Mon, 14 Apr 2008 09:51:29 -0500
References: <20080311171045.GB4684@localhost.localdomain>
	<82E8E38A-C159-4C23-BDE8-086D4429F366@kernel.crashing.org>
	<20080411160654.GA25506@polina.dev.rtsoft.ru>
	<47FF9665.7020403@freescale.com>
	<20080411170657.GA15270@polina.dev.rtsoft.ru>
	<20080411171109.GA16119@polina.dev.rtsoft.ru>
	<47FF9BFE.5000201@freescale.com>
	<20080411172106.GA17786@polina.dev.rtsoft.ru>
	<20080411173100.GA20439@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>,
	Timur Tabi <timur@freescale.com>, linux-serial@vger.kernel.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 11, 2008, at 12:31 PM, Anton Vorontsov wrote:
> On Fri, Apr 11, 2008 at 09:21:06PM +0400, Anton Vorontsov wrote:
>> On Fri, Apr 11, 2008 at 12:12:30PM -0500, Timur Tabi wrote:
>>> Anton Vorontsov wrote:
>>>
>>>> Or maybe I'm thinking here in terms of "fsl,ucc"... and cell- 
>>>> index is
>>>> indeed should be -1... don't know. Please decide. ;-)
>>>
>>> Well, that's what I was thinking.  cell-index is zero-based, so  
>>> UCC1 should have
>>> cell-index = <0>.
>>>
>>> Of course, this means all the code needs to change, since I think  
>>> device-id is
>>> one-based.
>>
>> Yup. You raised a really good question, because we're _introducing_
>> cell-index for UCC nodes, and if we'll choice wrong numbering scheme
>> now, then there will be no way back w/o breaking backward  
>> compatibility.
>
> Hm... thinking about it more, we're introducing implementation for the
> cell-index, but device tree was "infected" already.
>
> So, too late. :-D

I say leave as you have it (UCC1 == cell-index = <1>).

Changing it so cell-index = <0> is just more confusing w/regards to  
the docs.

- k
