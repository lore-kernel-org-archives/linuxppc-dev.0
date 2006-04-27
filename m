Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 48E75679F3
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 07:05:30 +1000 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1FZCeg-0001F7-0p
	for linuxppc-dev@ozlabs.org; Thu, 27 Apr 2006 22:00:02 +0200
Received: from p508176ef.dip.t-dialin.net ([80.129.118.239])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 22:00:02 +0200
Received: from info by p508176ef.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 22:00:02 +0200
To: linuxppc-dev@ozlabs.org
From: Heiko Joerg Schick <info@schihei.de>
Subject: Re: [PATCH 00/16] ehca: IBM eHCA InfiniBand Device   Driver
Date: Thu, 27 Apr 2006 21:50:28 +0200
Message-ID: <e2r7a0$fo2$1@sea.gmane.org>
References: <4450B378.9000705@de.ibm.com>
	<20060427125726.GK32127@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: news <news@sea.gmane.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	openib-general@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 2006-04-27 14:57:26 +0200, Jörn Engel <joern@wohnheim.fh-wedel.de> said:

> Don't expect much cheer and rejoicing over this.  I suspect that akpm
> or Linus will either want the 17 patches merged into one or have a
> patchset where every single patch leaves the kernel in a working
> state, including working eHCA driver.

I don't like the idea to put the whole driver in one patch file. I 
would propose to put the patch "ehca: integration in Linux kernel" last 
instead
of first, as Arnd mentioned. With that change we leave the kernel in a
working state when applying the patches.

Regards,
	Heiko
