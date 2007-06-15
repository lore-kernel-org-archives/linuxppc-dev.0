Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F2B38DDFD6
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 04:12:44 +1000 (EST)
Message-ID: <4672D694.5060701@freescale.com>
Date: Fri, 15 Jun 2007 13:12:36 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: for-2.6.23 branch in powerpc.git created
References: <18034.6787.951861.623265@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.60.0706151915580.5979@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0706151915580.5979@poirot.grange>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guennadi Liakhovetski wrote:
> These two i2c patches:
> 
> http://ozlabs.org/pipermail/linuxppc-dev/2007-June/037327.html

This looks OK as an interim measure, though at some point I'd like to 
get around to letting both devices and drivers specify a list of match 
names.

> http://ozlabs.org/pipermail/linuxppc-dev/2007-June/037328.html

I'd leave out the device_type, and the "rtc" in "rtc-r5c372" is 
redundant if that's all the r5c372 chip does, but other than that it 
looks good.

> also would be nice to get in, although, they only make sense with an ack 
> from Scott Wood and another patch from him, as explained in links above...

I assume you mean "Call of_register_i2c_devices() for fsl-i2c"
(http://ozlabs.org/pipermail/linuxppc-dev/2007-May/036333.html)?

-Scott
