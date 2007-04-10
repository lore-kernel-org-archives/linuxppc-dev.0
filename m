Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 06621DDF58
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 08:34:49 +1000 (EST)
Subject: Re: Cannot open ramdisk
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris West <chrisw@cristie.com>
In-Reply-To: <E1AF14BEE9B355499E146B179F69E9AF152EB6@exchangesrv.cristie.co.uk>
References: <E1AF14BEE9B355499E146B179F69E9AF152EB6@exchangesrv.cristie.co.uk>
Content-Type: text/plain
Date: Wed, 11 Apr 2007 08:34:38 +1000
Message-Id: <1176244478.8061.55.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> My ramdisk is a compressed 64MB ext3 filesystem in /ppc/chrp/system
> 
> After the kernel has booted I get the following message:
> 
> VFS: Cannot open root device "ram0" or unknown-block(1,0)
> Please append a correct "root=" boot option
> 
> I've read that only uncompressed kernels can load a ramdisk, is this still the case?
> I have tried using an uncompressed kernel with the same results.
> 
> Can anyone tell me why my ramdisk isn't being loaded?

Not sure... what is the full kernel log and the messages from yaboot ?
It's possible that your ramdisk is just too big for either yaboot or the
kernel to cope...

Also, the ramdisk should be compressed, is it ?

Ben.
