Return-Path: <dwm@maxeymade.com>
Received: from bebe.enoyolf.org (falcon30.maxeymade.com [24.173.215.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.maxeymade.com",
	Issuer "ChainedSSL Certificate Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 00F38679A6
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 09:32:05 +1000 (EST)
In-reply-to: <41C6BB03-59B9-4954-815B-7750B0996AB9@kernel.crashing.org>
References: <20060619171943.7730@bebe.enoyolf.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: OFW node names 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 19 Jun 2006 18:31:55 -0500
Message-ID: <20060619233155.361570@bebe.enoyolf.org>
From: Doug Maxey <dwm@maxeymade.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 20 Jun 2006 00:11:55 +0200, Segher Boessenkool wrote:
> > Does any platform known to use yaboot (or grub for that matter) use  
> > the
> > preferred encoding of the manufacturer portion of the name property?
> > How about the "ONNNNN" OUI from the RAC, or the uppercase VWXYZ  
> > company stock symbol?
> 
> Apple sometimes uses AAPL.  Never seen the ONNNNNN thing.

matches the US stock symbol, goodness.

> 
> > My view has been limited to the IBM platform.  According to the
> > examples, this is a recommended practice.  I know IBM uses the
> > lowercase variant.
> 
> Which _is_ allowed, although discouraged.

Ok, but who enforces it?  Vendor polices themselves?  Right. :->  

Thanks!

++doug
