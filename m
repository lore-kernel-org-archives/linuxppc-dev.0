Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 1F55DDDF0C
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 05:46:12 +1000 (EST)
Message-ID: <46A7A8FB.5090909@ru.mvista.com>
Date: Wed, 25 Jul 2007 23:48:11 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/2] [IDE] Platform IDE driver (was: MMIO IDE driver)
References: <20070725165318.5331.23795.stgit@localhost.localdomain>
	<Pine.LNX.4.60.0707252130090.6234@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0707252130090.6234@poirot.grange>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guennadi Liakhovetski wrote:

>>This is now very similar to pata_platform.c, they both use
>>same platform data structure and same resources.

>>To achieve that, byte_lanes_swapping platform data variable
>>and platform specified iops removed from that driver. It's fine,
>>since those were never used anyway.

>>pata_platform and ide_platform are carrying same driver names,
>>to easily switch between these drivers, without need to touch
>>platform code.

> Why? There's a drivers/ide/arm/ide_arm.c IDe driver that some platforms 
> (not in the mainline) hack to access, e.g., CF cards in true-IDE mode. 
> About a month ago I submitted a patch to arm-linux-kernel switching that 

    Wrong list to submit sych stuff, post to linux-ide.

> driver to using platform-device. I got a reply, that it's not worth it now 
> that IDE is slowly becoming obsolete, and the pata_platform serves the 
> perpose perfectly well. I found this argument reasonable, I had the same

    Ignore such replies in the future. ;-)

> doubt, just wanted to double-check. So, why do we now need a new legacy 
> (a/drivers/ide/legacy/ide_platform.c) driver when a "modern" driver 
> exists?

    Good question (I know the answer but won't tell ;-).

> Thanks
> Guennadi

MBR, Sergei
