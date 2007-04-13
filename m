Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 259B3DDF04
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Apr 2007 06:27:12 +1000 (EST)
Message-ID: <461FE7B7.6010202@mvista.com>
Date: Fri, 13 Apr 2007 13:27:35 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: booke_wdt being a kernel module
References: <8746466a0704121254h205a8247u39587560991f07a4@mail.gmail.com>
	<1A484369-13F5-49A0-8BFF-3DC290316BEF@kernel.crashing.org>
In-Reply-To: <1A484369-13F5-49A0-8BFF-3DC290316BEF@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Apr 12, 2007, at 2:54 PM, Dave wrote:
>
>   
>> Does it make sense for the booke_wdt driver to be a kernel module?
>> Since the watchdog cannot be stopped, unloading the module after the
>> watchdog has started basically garantees a reboot.... Should
>> CONFIG_BOOKE_WDT be changed to a bool from tristate?
>>     
>
> I don't see any value in making the booke_wdt driver a module.
>
> - k
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>   
Ok, I will make a patch to change it to bool then.
