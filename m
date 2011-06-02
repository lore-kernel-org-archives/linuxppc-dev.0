Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EE4EEB6F8F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jun 2011 10:47:16 +1000 (EST)
Subject: Re: 3.0-rc1: powerpc hangs at Kernel virtual memory layout
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Kujau <lists@nerdbynature.de>
In-Reply-To: <alpine.DEB.2.01.1106011712270.21697@trent.utfs.org>
References: <alpine.DEB.2.01.1105311644010.21697@trent.utfs.org>
	<alpine.DEB.2.01.1106011712270.21697@trent.utfs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 02 Jun 2011 10:47:06 +1000
Message-ID: <1306975626.29297.48.camel@pasglop>
Mime-Version: 1.0
Cc: zajec5@gmail.com, linux ppc dev <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-06-01 at 17:16 -0700, Christian Kujau wrote:
> ccc7c28af205888798b51b6cbc0b557ac1170a49 is the first bad commit
> commit ccc7c28af205888798b51b6cbc0b557ac1170a49
> Author: Rafał Miłecki <zajec5@gmail.com>
> Date:   Fri Apr 1 13:26:52 2011 +0200
> 
>     ssb: pci: implement serdes workaround
>     
>     Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
>     Signed-off-by: John W. Linville <linville@tuxdriver.com>
> -----------------------
> 
> When I reverted this one from the gi-bisected tree, the box continued to 
> boot (until it got stuck again during IDE/CDROM init, but that may be a 
> different story). I'l; try to revert this from a vanilla 3.0-rc1 and see 
> if it helps 

Thanks. I'll have a look later today. As for the IDE/CDROM init, have
you tried the very latest linus snapshot ? Does that still happens ?
What kind of error do you observe ?

There was some time during the 3.0 merge window process when interrupts
were broken on some PowerBooks, but that should be fixed now.

Cheers,
Ben.
