Return-Path: <msm@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 96FD167F41
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Aug 2005 03:20:29 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	j7FHStkK029564 for <linuxppc-embedded@ozlabs.org>;
	Mon, 15 Aug 2005 10:28:55 -0700 (MST)
Received: from az33exm43.am.freescale.net (az33exm43.am.freescale.net
	[10.64.34.249])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id j7FHO8iM016528
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 15 Aug 2005 12:24:08 -0500 (CDT)
From: Matthew McClintock <msm@freescale.com>
To: "Maziah Mat @ Mohamad" <mmezique@yahoo.com>
In-Reply-To: <20050815033633.12423.qmail@web52409.mail.yahoo.com>
References: <20050815033633.12423.qmail@web52409.mail.yahoo.com>
Content-Type: text/plain
Date: Mon, 15 Aug 2005 12:22:00 -0500
Message-Id: <1124126520.2576.11.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: error when loading shared library
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

First off it is bad idea to post HTML to this list, you are more likely
to get a response if you post plain text.

On Sun, 2005-08-14 at 20:36 -0700, Maziah Mat @ Mohamad wrote: 
> Hi,
>  
> I working with MPC8560ADS development which loaded with the ppc-linux
> glibc -3.3.2.
> 
You should be a bit more specific about your setup. What version of the
kernel are you running? Where did you get your root file system?

> When running the software, faced error which state error while loading
> shared libraries:/lib/libdb.so.3.. 

You are missing the db library on your root file system. Berkeley DB can
provide this library I believe. You need to download it, and compile for
your target.

>  
> Could you please advise, where is the good link to download the
> required shared libraries that working for ppc-linux.

Your best bet would be to do a search on google.

-Matthew 
