Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id EE4B3DDDF6
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  8 Dec 2008 10:31:49 +1100 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L9T6F-0006vJ-7H
	for linuxppc-embedded@ozlabs.org; Sun, 07 Dec 2008 23:31:44 +0000
Received: from CPE-124-190-96-129.vic.bigpond.net.au ([124.190.96.129])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Sun, 07 Dec 2008 23:31:43 +0000
Received: from daniel_ng11 by CPE-124-190-96-129.vic.bigpond.net.au with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Sun, 07 Dec 2008 23:31:43 +0000
To: linuxppc-embedded@ozlabs.org
From: Daniel Ng <daniel_ng11@lycos.com>
Subject: Re: i2c support for MPC 8247
Date: Sun, 7 Dec 2008 23:31:35 +0000 (UTC)
Message-ID: <loom.20081207T233039-159@post.gmane.org>
References: <loom.20081204T014044-850@post.gmane.org>
	<200812040958.28687.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Laurent Pinchart <laurentp <at> cse-semaphore.com> writes:
> The MPC8247 I2C controller is supported by the i2c-cpm driver, introduced in 
> 2.6.27. It shouldn't be difficult to backport the driver to 2.6.24. Please 
> note that the driver only supports the powerpc architecture and won't work 
on 
> ppc kernels.
> 
> Alternatively, you could port the i2c-mpc8260 driver to 2.6.24.
> 

Great! Thanks for the info Laurent.

Daniel
