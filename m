Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EFD59DDDEF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Oct 2008 07:46:13 +1100 (EST)
Message-ID: <490779EF.1060207@freescale.com>
Date: Tue, 28 Oct 2008 15:45:35 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Joaquin Luna <Joaquin.Luna@jdsu.com>
Subject: Re: MPC8313E RDB: Badness at fs/sysfs/dir.c:463
References: <48F49D7D.5070107@provision-comm.com>	<48F4A8CD.6000101@provision-comm.com>	<22A97B63-36D5-44BA-8F49-BAF5870FA08A@kernel.crashing.org>	<1224065185.457.31.camel@mike-linux.provision-comm.com><1225209233.937.6.camel@mike-linux.provision-comm.com>
	<490739FC.6020803@freescale.com>
	<DF6C7BC3780EE44B83430A9F756D43B6081E5D5D@SJEXCH03.ds.jdsu.net>
In-Reply-To: <DF6C7BC3780EE44B83430A9F756D43B6081E5D5D@SJEXCH03.ds.jdsu.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Joaquin Luna wrote:
> I am having the same problem with badness at fs/sysfs/dir.c on the
> MPC8313ERDB.  More importantly my custom board based on this development
> board will not boot past "loading device tree." 

That's probably unrelated.

> Are there any other
> mismerges in this file? 

Not that I know of.

> If we fix the dts file how do we fix the
> official dts file 

With a patch.

> and when would that fix be put in place?

When the patch is applied. :-)

-Scott
