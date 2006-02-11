Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 7D11E67BA2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 11:12:07 +1100 (EST)
To: atul.sabharwal@exgate.tek.com
From: Wolfgang Denk <wd@denx.de>
Subject: Re: kernel startup 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 10 Feb 2006 16:02:24 PST."
	<4A062D477D842B4C8FC48EA5AF2D41F201BA2081@us-bv-m23.global.tektronix.net>
Date: Sat, 11 Feb 2006 01:12:04 +0100
Sender: wd@denx.de
Message-Id: <20060211001204.294113535F1@atlas.denx.de>
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

In message <4A062D477D842B4C8FC48EA5AF2D41F201BA2081@us-bv-m23.global.tektronix.net> you wrote:
> 
> I am using PPC 870 and u-boot 1.1.2.  Which architecture should I look
> for as a reference example.  On my system, the RAM is not at address 0x0 but at
> 0x10000000. Since the exception table does not take full 32 bit address,

The phrase "the RAM is at address 0x10000000" is bogus.

The RAM "is" where you map it. The mapping is done in  software.  The
software is implementing your design.

In other words, your design is broken when you put the RAM at such  a
strange adress instead of the natural location, starting from 0x0000.

> I am not sure how to tell the processor about the relocated location.

You don't; just fix your memory map.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If God had a beard, he'd be a UNIX programmer.
