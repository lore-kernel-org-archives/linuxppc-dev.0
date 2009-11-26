Return-Path: <albert_herranz@yahoo.es>
Received: from smtp134.mail.ukl.yahoo.com (smtp134.mail.ukl.yahoo.com
	[77.238.184.65]) by ozlabs.org (Postfix) with SMTP id BCE261007D7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 02:28:06 +1100 (EST)
Message-ID: <4B0E9E84.4060400@yahoo.es>
Date: Thu, 26 Nov 2009 16:28:04 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH 09/19] powerpc: gamecube/wii: udbg support for usbgecko
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>	
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1259212354.16367.265.camel@pasglop>
In-Reply-To: <1259212354.16367.265.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Sun, 2009-11-22 at 23:01 +0100, Albert Herranz wrote:
>> Add support for using the USB Gecko adapter via the udbg facility on
>> the Nintendo GameCube and Wii video game consoles.
>> The USB Gecko is a 3rd party memory card interface adapter that provides
>> a EXI (External Interface) to USB serial converter.
> 
> The main issue here is that the gecko is supposed to be something you
> can plug or unplug no ? Is it hotswap or only at boot ? In the later
> case, maybe the node should be created by the boot wrapper when
> detecting the presence of the device. If it's hotplug, then we need
> something smarter...
> 

The usbgecko is hotplugable and hotswappable.
But as this is mostly a developer feature, not normaly used by end users, I think that we can just let it be as it is: autodetect it on boot (now probing for it instead of using information from the device tree).
If you unplug it later it causes no errors, you just miss whatever data is sent to it.

> Cheers,
> Ben.
> 

Thanks,
Albert
