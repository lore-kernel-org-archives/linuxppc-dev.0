Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id D646FDDF23
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 04:18:39 +1000 (EST)
Date: Fri, 15 Jun 2007 20:18:32 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: for-2.6.23 branch in powerpc.git created
In-Reply-To: <4672D694.5060701@freescale.com>
Message-ID: <Pine.LNX.4.60.0706152016150.5979@poirot.grange>
References: <18034.6787.951861.623265@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.60.0706151915580.5979@poirot.grange>
	<4672D694.5060701@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 15 Jun 2007, Scott Wood wrote:

> Guennadi Liakhovetski wrote:
> > These two i2c patches:
> > 
> > http://ozlabs.org/pipermail/linuxppc-dev/2007-June/037327.html
> 
> This looks OK as an interim measure, though at some point I'd like to get
> around to letting both devices and drivers specify a list of match names.
> 
> > http://ozlabs.org/pipermail/linuxppc-dev/2007-June/037328.html
> 
> I'd leave out the device_type, and the "rtc" in "rtc-r5c372" is redundant if

No, it is not redundant, it has to match rs5c372_driver.driver.name.

> that's all the r5c372 chip does, but other than that it looks good.
> 
> > also would be nice to get in, although, they only make sense with an ack
> > from Scott Wood and another patch from him, as explained in links above...
> 
> I assume you mean "Call of_register_i2c_devices() for fsl-i2c"
> (http://ozlabs.org/pipermail/linuxppc-dev/2007-May/036333.html)?

Yes.

Thanks
Guennadi
---
Guennadi Liakhovetski
