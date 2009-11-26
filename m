Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8320B1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 10:05:09 +1100 (EST)
In-Reply-To: <4B0E9E84.4060400@yahoo.es>
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
	<1259212354.16367.265.camel@pasglop> <4B0E9E84.4060400@yahoo.es>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EAE17D04-D785-4652-9024-063980F494A4@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 09/19] powerpc: gamecube/wii: udbg support for usbgecko
Date: Fri, 27 Nov 2009 00:12:05 +0100
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> The usbgecko is hotplugable and hotswappable.
> But as this is mostly a developer feature, not normaly used by end  
> users, I think that we can just let it be as it is: autodetect it  
> on boot (now probing for it instead of using information from the  
> device tree).
> If you unplug it later it causes no errors, you just miss whatever  
> data is sent to it.

You can get interrupts when an EXI device is plugged or unplugged; the
"normal" driver should use that.  But you haven't posted that yet.

The "early debug" driver can just assume the user doesn't like to hurt
himself, and provide pain when the user does, there's no problem with
that :-)


Segher
