Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CCA7ADE0B4
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 23:07:38 +1000 (EST)
Message-ID: <49F0680C.1040205@freescale.com>
Date: Thu, 23 Apr 2009 08:07:24 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: removing get_immrbase()??
References: <A6732FD8-FBC6-420F-9318-CC111D266993@kernel.crashing.org>
	<ed82fe3e0904221235i51fb75dap44b1fad09a10ea91@mail.gmail.com>
	<49EF7B11.2000006@freescale.com> <49EF7B1C.2080105@freescale.com>
	<282847E1-AE1A-44EF-9D18-AF2884105FA5@kernel.crashing.org>
	<49EF8E3A.4060304@freescale.com>
	<5D0145E3-0A98-429E-8D53-1A8DF4216462@kernel.crashing.org>
	<20090423022610.GA19376@yookeroo.seuss>
	<80CA86D4-3DA5-4C28-AE7A-C03CE5758774@kernel.crashing.org>
In-Reply-To: <80CA86D4-3DA5-4C28-AE7A-C03CE5758774@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>,
	Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> Until we meet the most basic level of properly describing 95% of the  
> HW I don't see the value you guys prescribe to FW compatibility.   
> Additionally I believe for embedded developers its perfectly  
> reasonable to expect them (if they are using u-boot) to possibly have  
> to update their .dts/dtb if they want to update their kernel.

That sounds like you want to throw out the baby with the bathwater.
Just because we can't get close to 100% representation of the hardware
in the DTS, that does not mean that the representation we do have should
be considered tenuous (for lack of a better word).

We should *strive* to maintain backwards compatibility.  If that means
adding a few lines of isolated code every now and then, I don't see that
as a bad thing at all.

-- 
Timur Tabi
Linux kernel developer at Freescale
