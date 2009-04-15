Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3957EDE1A0
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 03:20:22 +1000 (EST)
Message-Id: <19D58213-D01B-47C1-8A78-6C1D86E624AE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20090415161728.GA5670@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: fixed phy -- how do we decide to use this code?
Date: Wed, 15 Apr 2009 12:20:14 -0500
References: <B660E2DF-5F6A-4939-9D20-3AB8E7C69EDB@kernel.crashing.org>
	<20090415161728.GA5670@oksana.dev.rtsoft.ru>
Cc: netdev@vger.kernel.org, Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 15, 2009, at 11:17 AM, Anton Vorontsov wrote:

> On Wed, Apr 15, 2009 at 10:54:40AM -0500, Kumar Gala wrote:
>> Vitaly, Anton
>>
>> You guys have used this code.. I was wondering how we decide to  
>> used the
>> fixed phy vs another phy.  Is this a runtime decision based on  
>> something
>> in the device tree or purely at compile time?
>
> It's specified via fixed-link property in the device tree.
> The bindings described in Documentation/powerpc/dts-bindings/fsl/ 
> tsec.txt.

Ok, I want to make sure I can build a platform that uses a normal PHY  
that is detected (like a marvell PHY) and and have another platform  
that is fixed-link in the same kernel image.  Sounds like we'll be ok.

- k
