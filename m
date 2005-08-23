Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 4CE3B6817A
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Aug 2005 03:04:47 +1000 (EST)
In-Reply-To: <1124815395.29448.26.camel@hades.cambridge.redhat.com>
References: <1124815395.29448.26.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <68765056-7D19-42A4-9E25-22C036AE5E05@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 23 Aug 2005 12:04:38 -0500
To: David Woodhouse <dwmw2@infradead.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: When are machine checks suppose to be recoverable?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 23, 2005, at 11:43 AM, David Woodhouse wrote:

> On Mon, 2005-08-22 at 23:56 -0300, Marcelo Tosatti wrote:
>
>> "My dual G4 PowerMac crashes sometimes when it probes for the  
>> (absent)
>> serial ports. Theoretically it's supposed to take a machine check and
>> recover -- but it doesn't always work like that."
>>
>> Maybe you just need the proper entry in the exception table for IO
>> inb/outb?
>>
>> Is there a stacktrace, David?
>>
>
> No, just a silent death when probing for one of the serial ports;
> usually not the first. It doesn't seem to even make it into the  
> machine
> check handler. Adding printks into serial_inb and serial_outb makes it
> much less likely to happen -- could be something bizarre about  
> alignment
> of the instructions which cause the machine check, or time elapsed  
> from
> one machine check to the next.

If the machine is locking hard it could be check stopping due to  
getting a second machine check.

- kumar
