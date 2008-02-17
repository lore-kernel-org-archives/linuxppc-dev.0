Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9088DDDE1D
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 17 Feb 2008 19:05:09 +1100 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JQe82-000652-4g
	for linuxppc-embedded@ozlabs.org; Sun, 17 Feb 2008 07:40:02 +0000
Received: from adsl-75-50-169-229.dsl.lsan03.sbcglobal.net ([75.50.169.229])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Sun, 17 Feb 2008 07:40:02 +0000
Received: from thomas.a.werne by adsl-75-50-169-229.dsl.lsan03.sbcglobal.net
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Sun, 17 Feb 2008 07:40:02 +0000
To: linuxppc-embedded@ozlabs.org
From: Thomas Werne <thomas.a.werne@jpl.nasa.gov>
Subject: Re: APU FPU in Virtex ppc405
Date: Sun, 17 Feb 2008 07:34:59 +0000 (UTC)
Message-ID: <loom.20080217T072721-349@post.gmane.org>
References: <47ACA4BB.6010903@gmail.com>
	<fa686aa40802081132h22b91464xd150e0671ca4fc34@mail.gmail.com>
	<47B02CB0.8040002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

A. Nolson <alohanono <at> gmail.com> writes:

> 
> I have been checking and it seems that the APU FPU patches will give 
> some headaches now, so I will probably wait until they merge them with 
> the official GCC release. In any case, it seems that the FPU restricts 
> the PowerPC and bus frequencies to a max of 200/100.
> 
> Anyway, thanks for the info. I will try to keep track of this in case of 
> an update.
> 

Hi -

You can get the FPU to work with the 2.6.24rc3 Linux (I got it to work just
yesterday).  There are a couple of small changes you have to make to kernel
config files and to one of the .h files, plus you need to compile with the
-fshort-double flag to convert all doubles into floats.  Let me know if you're
still interested and I can post details and/or patches.

Thomas

--
Thomas Werne
NASA Jet Propulsion Laboratory

All personal and professional opinions presented herein are my
own and do not, in any way, represent the opinion or policy of JPL.
