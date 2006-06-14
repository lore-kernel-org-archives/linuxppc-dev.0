Return-Path: <AZeffertt@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5507A67B68
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Jun 2006 18:47:29 +1000 (EST)
Message-ID: <448FCD17.1060108@cambridgebroadband.com>
Date: Wed, 14 Jun 2006 09:47:19 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: No ttyS device at I/O port 0xfe004500 for console
References: <448EEC59.2010201@cambridgebroadband.com>
	<2CFF4933-A9D2-4981-BD11-C38537CE193B@kernel.crashing.org>
In-Reply-To: <2CFF4933-A9D2-4981-BD11-C38537CE193B@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Kumar Gala wrote:
> 
> On Jun 13, 2006, at 11:48 AM, Alex Zeffertt wrote:
> 
>> Hi list,
>>
>> I'm trying to boot a linux-2.6.11 kernel on a MPC83xx based board.  
>> Through
>> some experimentation I have found I need "console=uart,io,0xfe004500"
>> in the kernel command line in order to get any output over the serial
>> port.
>>
>> Half way through initialisation the kernel appears to swap from its 
>> "early"
>> 8250 serial driver to a "full" 8250 serial driver.  At this point it 
>> prints
>> "No ttyS device at I/O port 0xfe004500 for console" and there is no
>> further output.
>>
>> Does anyone have any idea what I may be doing wrong?
>>
>> BTW, here's the output that I do get.
> 
> Alex, where did you get this 2.6.11 kernel?  The public tree didn't have 
> support for 83xx in 2.6.11.  I'd suggest looking at using something 
> newer like 2.6.16 and see if you have the same issue.
> 
> - k

Hi Kumar, I got it from Freescale's MPC8323EMDS linux BSP.

As far as I am aware this is the only source which has support for this
board.  (Hopefully they will eventually upstream their changes!)

I'll have a look at 2.6.11 and see whether it is feasable to port
the board support to it.

Thanks,

Alex
