Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F02F5DDDDB
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 08:50:11 +1000 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Ib2BG-0008OF-3H
	for linuxppc-dev@ozlabs.org; Thu, 27 Sep 2007 22:50:03 +0000
Received: from p5497ea2e.dip.t-dialin.net ([84.151.234.46])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 22:50:02 +0000
Received: from dzu by p5497ea2e.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 22:50:02 +0000
To: linuxppc-dev@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: jffs2 file system on MPC8272ADS board
Date: Thu, 27 Sep 2007 17:14:20 +0200
Message-ID: <m27imc2l9v.fsf@ohwell.denx.de>
References: <12873530.post@talk.nabble.com>
	<20070925202257.559a78c5@ru.mvista.com>
	<12900017.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Nethra,

> The other options I am wondering about,
>   -c, --cleanmarker=SIZE Size of cleanmarker (default 12)
>   -n, --no-cleanmarkers  Don't add a cleanmarker to every eraseblock
> cleanmaker size will it help the cause?

Skimming through the thread I cannot tell whether you use NAND or NOR,
but on NAND flash, the cleanmarkers are actually in the out-of-band
area and thus *should not* be in the image, so for NAND we need the -n
option.

I don't think you should have to adjust the size, at least I never
needed this.

Best wishes
  Detlev

-- 
I've been examining the existing [linux]  kernel configuration system, and I
have about concluded that the best favor we could do everybody involved with
it is to take it out behind the barn and shoot it through the head.
                           -- Eric S. Raymond on linux-kbuild Mar 2000
--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
