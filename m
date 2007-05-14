Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ABAD4DDD09
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 05:30:11 +1000 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HngF8-000747-4P
	for linuxppc-dev@ozlabs.org; Mon, 14 May 2007 21:30:02 +0200
Received: from bi01p1.co.us.ibm.com ([32.97.110.142])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 21:30:02 +0200
Received: from hollisb by bi01p1.co.us.ibm.com with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 21:30:02 +0200
To: linuxppc-dev@ozlabs.org
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: Building ppc/powerpc kernel to run under QEMU.
Date: Mon, 14 May 2007 14:09:59 -0500
Message-ID: <pan.2007.05.14.19.09.58.730326@us.ibm.com>
References: <200705092203.26042.rob@landley.net>
	<20070510172806.GE4452@austin.ibm.com>
	<200705112114.58053.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: news <news@sea.gmane.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 11 May 2007 21:14:57 -0400, Rob Landley wrote:
> 
> The Open Hackware bootloader used by QEMU insists on a boot partition, even 
> when I use "-kernel" to use the built-in bootloader.  But the prep kernel is 
> apparently formatted to look like a boot partition, or close enough for the 
> firmware to recognize it.  (The macintosh-style kernels require a hard drive 
> image in order for the firmware to like them.  So I can't boot one of those 
> with "qemu -kernel filename" even if I build it right.)

Why don't you try dumping OpenHackware entirely? With small modifications
to OpenBIOS's briQ build, I got pretty far under qemu's PReP emulation.
The biggest problem was that the briQ 16550 driver was not correct (maybe
it worked on hardware, but it didn't follow spec and failed under qemu).

I got up to "ok, now how do I boot from the Forth prompt?" before running
out of time.

-- 
Hollis Blanchard
IBM Linux Technology Center
