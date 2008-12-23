Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id B027DDDD0C
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Dec 2008 19:06:39 +1100 (EST)
Received: from [192.168.1.37] (66-81-71-74.bayarea.dialup.o1.com [66.81.71.74])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id mBN86MVS084373
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Dec 2008 00:06:33 -0800 (PST)
Message-ID: <49509B3E.9000003@hypersurf.com>
Date: Tue, 23 Dec 2008 00:03:10 -0800
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: schizophrenic G5 ...
References: <494EDB3F.4090604@hypersurf.com> <1229979795.4360.18.camel@pasglop>
In-Reply-To: <1229979795.4360.18.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Sun, 2008-12-21 at 16:11 -0800, Kevin Diggs wrote:
> 
>>Hi,
>>
>>	I have a water cooled dual 2.5 GHz G5 (Powermac7,3). It has YDL 6.0 on 
>>it. Using the stock YDL 2.6.23 kernel this machine "appears" to work fine.
>>
>>	After finally getting it to boot under 2.6.27, it will shut itself off 
>>if put under any significant load. And it is doing it very quickly. Like 
>>within a few seconds of becoming busy. I just discovered it is spitting 
>>out messages about "temperature way above maximum" (from therm_pm72.c).
>>
>>	This one has the Panasonic cooling system. I have checked behind the 
>>cover and see no evidence of leaks.
>>
>>	When put under load under the stock YDL kernel, the cpu fans will speed 
>>up for about 2 minutes. Then over the next minute or so they will slow 
>>down almost to idle. Thereafter a whirring sound can be heard every 15 
>>to 30 seconds lasting about 5 seconds. Which I am guessing is the pump? 
>>The exhaust air barely gets warm?
>>
>>	Anyone have any ideas? Could the cooling system NOT be correctly 
>>thermally connected to the cpus?
> 
I would appreciate it if one of the many people on this list that are 
way more smarterer than me could tell me something like, "If this were 
true you would have toasted the cpus already!"
> 
> I have approx. the same here taking dust under the desk, I'll give it a
> spin but i might have to wait a couple of days...
> 
> If mine works, then we'll have to run some more intensive debugging to
> see what's going on.
> 
> Cheers,
> Ben.
> 
> 
Ben,

	I would appreciate it. I am now kinda afraid to turn the thing on.
