Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id 80C3FDE2DB
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 01:45:39 +1100 (EST)
Message-ID: <4964C00E.1090208@harris.com>
Date: Wed, 07 Jan 2009 09:45:34 -0500
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [QUESTION] 440EPx with PCI to PCIe bridge error
References: <496268E7.5090907@harris.com>	 <1231190318.14860.17.camel@pasglop>
	<49627D33.8030605@harris.com>	 <1231223634.14860.18.camel@pasglop>
	<4963C1DE.6020007@harris.com>	 <4963CF68.3040808@harris.com>
	<1231279340.14860.31.camel@pasglop>	 <4963D989.6090909@harris.com>
	<1231283623.14860.32.camel@pasglop>
In-Reply-To: <1231283623.14860.32.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> 
>> I'm not sure if this should be changed in the mainline.  This card works
>> out of the box when used with a generic x86 PC, but not when used with
>> a sequoia.  But, maybe it's just me climbing the PPC learning curve.
> 
> Nah, I think 256M is ridiculously small :-) I think the .dts for that
> board should be changed, there is plenty of physical address space
> available on those chips since it's using a 36-bit bus.
> 
> Cheers,
> Ben.
>  

Sheepish grin:  I did more checking, and the current mainline actually has
this set to 1 GB.

The .dts I'm using dates back to 2.6.25.  I had started modifying it for some
custom peripherals we have hacked onto a Sequoia, and I missed the changes
that were made between .25 and .28.

If you think 1 GB is a suitable default, then no further changes are needed.
If you think it should be bigger than 1 GB, then I could submit a patch.

	Steve
