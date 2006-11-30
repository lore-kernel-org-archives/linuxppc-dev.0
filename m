Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8E19C67B93
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Nov 2006 14:52:21 +1100 (EST)
In-Reply-To: <3C02138692C13C4BB675FE7EA240952922A134@bluefin.Soneticom.local>
References: <3C02138692C13C4BB675FE7EA240952922A134@bluefin.Soneticom.local>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BFE2C99E-7054-49AD-9F3D-A5FB499573B5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: For anybody using the e500 proc
Date: Wed, 29 Nov 2006 21:52:12 -0600
To: Clint Thomas <cthomas@Soneticom.com>
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


On Nov 29, 2006, at 3:34 PM, Clint Thomas wrote:

> Do you generate your own cross-compilers? Or do you use those  
> provided in the ELDK? If you build your own, what patch did you  
> apply to be able to build them with crosstool? I am having a hard  
> time getting a set of tools to work well with my system. I want to  
> use GCC 3.4.1 and GLIBC 2.3.3, and GDB 6.5. Thanks for any information

You can look at grabbing the tools from http://www.bitshrine.org/gpp/.

I'm trying to get an updated set of patches for building a gcc-4.x  
e500 cross compiler w/crosstool.

- k
