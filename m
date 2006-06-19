Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 71B7167B16
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 08:12:08 +1000 (EST)
In-Reply-To: <20060619171943.7730@bebe.enoyolf.org>
References: <20060619171943.7730@bebe.enoyolf.org>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <41C6BB03-59B9-4954-815B-7750B0996AB9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: OFW node names 
Date: Tue, 20 Jun 2006 00:11:55 +0200
To: Doug Maxey <dwm@maxeymade.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Does any platform known to use yaboot (or grub for that matter) use  
> the
> preferred encoding of the manufacturer portion of the name property?
> How about the "ONNNNN" OUI from the RAC, or the uppercase VWXYZ  
> company stock symbol?

Apple sometimes uses AAPL.  Never seen the ONNNNNN thing.

> My view has been limited to the IBM platform.  According to the
> examples, this is a recommended practice.  I know IBM uses the
> lowercase variant.

Which _is_ allowed, although discouraged.


Segher
