Return-Path: <tnt@246tNt.com>
Received: from outmx018.isp.belgacom.be (outmx018.isp.belgacom.be
	[195.238.2.117]) by ozlabs.org (Postfix) with ESMTP id 1E68D67A80
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Feb 2005 10:45:23 +1100 (EST)
Received: from outmx018.isp.belgacom.be (localhost [127.0.0.1])
	by outmx018.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j1GNjA7q021839
	for <linuxppc-embedded@ozlabs.org>; Thu, 17 Feb 2005 00:45:10 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4213DAEE.5000802@246tNt.com>
Date: Thu, 17 Feb 2005 00:44:46 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Matej Kupljen <matej.kupljen@ultra.si>,
	linuxppc-embedded@ozlabs.org
References: <1108547431.30212.37.camel@mbmatejdebian.ultra.si>	<4213B356.3060901@246tNt.com>
	<1108588896.15304.7.camel@orionlinux.starfleet.com>
In-Reply-To: <1108588896.15304.7.camel@orionlinux.starfleet.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Subject: Re: bdi2000 debugging
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>>The bad news : AFAIK you can't fix it :(
>>
>>There is a bug in the rev <= 1.2 of the silicon of MPC5200 : When there
>>is another XLB Master active (like USB or any bestcomm activity), the XLB
>>arbiter can get confused during debugging and you can resume nor
>>can you access memory or do anything ... you can just reboot.
>>    
>>
>
>Hmm, this is not good. :(
>  
>
No kidding ;)

>How can I determine the silicon rev.?
>I'll look it up in the docs.
>  
>
L25R marking on the top means rev 1.2 IIRC. That's the one I have. Also, 
if you have a
rev 2, you're lucky, I'd like one ;)

>>It's VERY frustrating since the BDI2000 is then kind of useless for debug
>>in the cases when you need those activated ...
>>    
>>
>
>So I have to disable USB (can live without it for debugging), bestcomm
>(hmm, how can I use console on serial port then?) and what else?
>  
>
Serial port console is OK the drivers I know don't use bestcomm. But
USB, Ethernet, IDE, Codec, ....


    Sylvain
