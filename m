Return-Path: <tnt@246tNt.com>
Received: from outmx017.isp.belgacom.be (outmx017.isp.belgacom.be
	[195.238.4.116])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 226A9DDDE4
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Feb 2007 22:02:04 +1100 (EST)
Received: from outmx017.isp.belgacom.be (localhost [127.0.0.1])
	by outmx017.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l1JB1ukZ029563
	for <linuxppc-embedded@ozlabs.org>; Mon, 19 Feb 2007 12:01:57 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45D9839A.9010503@246tNt.com>
Date: Mon, 19 Feb 2007 12:01:46 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Domen Puncer <domen.puncer@telargo.com>
Subject: Re: [RFC PATCHES] lite5200b low power mode works
References: <20061222105404.GC2481@moe.telargo.com>
	<20070123093339.GF4397@moe.telargo.com>
	<20070219072146.GM4397@moe.telargo.com>
	<45D978C9.7050402@246tNt.com>
	<20070219110036.GN4397@moe.telargo.com>
In-Reply-To: <20070219110036.GN4397@moe.telargo.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Domen Puncer wrote:
> On 19/02/07 11:15 +0100, Sylvain Munaut wrote:
>   
>> Domen Puncer wrote:
>>     
>>> On 23/01/07 10:33 +0100, Domen Puncer wrote:
>>>   
>>>       
>>>> I'm planning on porting this to Grant/Sylvain's arch/powerpc mpc52xx
>>>> tree soon.
>>>>     
>>>>         
>>> OK... and I've done that (mainline kernel + FEC/bestcomm patches)
>>> + some cleanups, fixes.
>>>
>>> Any of you guys interested in having this in your tree?
>>>
>>>   
>>>       
>> Sure, feel free to post them.
>>     
>
> It seems to be my lucky day. I just figured out what I was doing
> wrong with deep-sleep (aplicable to all mpc52xx), so I'll delay this
> a few days, and send patches implementing both mpc5200b and lite5200b
> "suspend to ram" modes.
>   
Even better !

    Sylvain
