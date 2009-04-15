Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 83C59DE28F
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 03:25:15 +1000 (EST)
Date: Wed, 15 Apr 2009 21:25:14 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: fixed phy -- how do we decide to use this code?
Message-ID: <20090415172514.GA15292@oksana.dev.rtsoft.ru>
References: <B660E2DF-5F6A-4939-9D20-3AB8E7C69EDB@kernel.crashing.org>
	<20090415161728.GA5670@oksana.dev.rtsoft.ru>
	<19D58213-D01B-47C1-8A78-6C1D86E624AE@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <19D58213-D01B-47C1-8A78-6C1D86E624AE@kernel.crashing.org>
Cc: netdev@vger.kernel.org, Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 15, 2009 at 12:20:14PM -0500, Kumar Gala wrote:
>
> On Apr 15, 2009, at 11:17 AM, Anton Vorontsov wrote:
>
>> On Wed, Apr 15, 2009 at 10:54:40AM -0500, Kumar Gala wrote:
>>> Vitaly, Anton
>>>
>>> You guys have used this code.. I was wondering how we decide to used 
>>> the
>>> fixed phy vs another phy.  Is this a runtime decision based on  
>>> something
>>> in the device tree or purely at compile time?
>>
>> It's specified via fixed-link property in the device tree.
>> The bindings described in Documentation/powerpc/dts-bindings/fsl/ 
>> tsec.txt.
>
> Ok, I want to make sure I can build a platform that uses a normal PHY  
> that is detected (like a marvell PHY) and and have another platform that 
> is fixed-link in the same kernel image.  Sounds like we'll be ok.

Yep, that will work.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
