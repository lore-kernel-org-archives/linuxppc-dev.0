Return-Path: <tnt@246tNt.com>
Received: from outmx018.isp.belgacom.be (outmx018.isp.belgacom.be
	[195.238.2.117]) by ozlabs.org (Postfix) with ESMTP id 0D59167B2A
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Jun 2005 21:31:58 +1000 (EST)
Received: from outmx018.isp.belgacom.be (localhost [127.0.0.1])
	by outmx018.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j59BVr0S018918
	for <linuxppc-embedded@ozlabs.org>; Thu, 9 Jun 2005 13:31:54 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <42A828B7.4030305@246tNt.com>
Date: Thu, 09 Jun 2005 13:32:07 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Mark Chambers <markc@mail.com>
References: <528646bc05060816514c2d5860@mail.gmail.com>
	<002201c56ce5$561a6c50$0301a8c0@chuck2>
In-Reply-To: <002201c56ce5$561a6c50$0301a8c0@chuck2>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC52xx: sysfs failure on adding new device driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Mark

Mark Chambers wrote:
>>I'm working on an MPC52xx SPI device driver using one of the PSC. 
>>However, when I call driver_register() I get a failure (-17, EEXISTS)
>>with a traceback (posted below).
> 
> 
> Hey Grant,
> 
> This sounds exactly like a problem I had with PSC with devfs.  I posted
> a patch here on 5/27, I bet you'll find it's a similar problem.  
> 
> (Let me know if you don't have access to that patch, I'll forward you my
> copy)

Don't think so. Your patch applies to the 2.4 while Grant problem is 
specific to the way the different functions of PSCs are handled to work 
the 2.6 ppc_sys model.

btw, if not yet integrated you should send your patch to Wolfang, he's 
the one maintaining that tree.


	Sylvain
