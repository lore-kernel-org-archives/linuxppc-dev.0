Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0927367A0E
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 04:33:44 +1000 (EST)
In-Reply-To: <200604251329.35584.bcook@bpointsys.com>
References: <4C61B597-BD91-4D05-BB40-43DE0319F123@kernel.crashing.org>
	<265F73F8-F641-4EDD-B88F-A2B2F7FA1308@kernel.crashing.org>
	<20060425182418.GA1132@gate.ebshome.net>
	<200604251329.35584.bcook@bpointsys.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <248CD1B3-A33B-47F5-AFE8-F7C9DDCD1D0B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 85xx FDT updates?
Date: Tue, 25 Apr 2006 13:33:38 -0500
To: Brent Cook <bcook@bpointsys.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 25, 2006, at 1:29 PM, Brent Cook wrote:

> On Tuesday 25 April 2006 13:24, Eugene Surovegin wrote:
>> On Tue, Apr 25, 2006 at 01:14:55PM -0500, Kumar Gala wrote:
>>>> What you will end up with is that that small amount of embedded  
>>>> people
>>>> who bother to contribute something back will stop doing this. We  
>>>> are
>>>> more than capable of maintaining our internal kernel trees :).
>>>
>>> I'm not sure what to say to this.  Things need to move forward at
>>> some point.
>>
>> I don't see how removing features and breaking compatibility with
>> almost _all_ current embedded PPC boards boards is "moving forward".
>> Enlighten me, please.
>>
>>> I still not clear as to what exactly you are advocating
>>> beyond that we should keep the arch/ppc code around for ever.
>>
>> Providing compatibility for non-flat-tree firmware. This doesn't mean
>> keeping arch/ppc.
>
> Would it be possible to create the device tree in the kernel and  
> then jump
> into the normal entry point? We need some sort of translation shim  
> between
> the normal kernel and whatever oddball method firmware X chooses to  
> hand-off
> to the kernel.

Agreed, that would be nice.  I would love for someone to create such  
a thing.  I personally dont have any time or interesting in it.

- kumar
