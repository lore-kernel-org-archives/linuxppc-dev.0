Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id 8C5BDDDF08
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 Jun 2008 21:10:09 +1000 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1K4wJ8-0001dn-Aq
	for linuxppc-embedded@ozlabs.org; Sat, 07 Jun 2008 11:10:02 +0000
Received: from p5497fe98.dip.t-dialin.net ([84.151.254.152])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Sat, 07 Jun 2008 11:10:02 +0000
Received: from dzu by p5497fe98.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Sat, 07 Jun 2008 11:10:02 +0000
To: linuxppc-embedded@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: The 2.6.25 kernel dosen't run on pq2fads based board
Date: Sat, 07 Jun 2008 13:04:20 +0200
Message-ID: <m2d4mt4ibv.fsf@ohwell.denx.de>
References: <8496f91a0806040525u7e137221sc4bea5466cde3161@mail.gmail.com>
	<8496f91a0806051204w619eed31uee4feb812702707b@mail.gmail.com>
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

Hi Ilya,

> Solved. The problem was in zero-filled memory node in DTS file. U-boot
> doesn't fix it and the kernel gots wrong value. Thanks to Scot Wood.

So when do you post the patch for U-Boot? ;)

Cheers
  Detlev

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
