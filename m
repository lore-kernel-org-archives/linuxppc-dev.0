Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id 9CCEFDDF61
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 Jun 2008 21:15:09 +1000 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1K4wNy-0001rC-NR
	for linuxppc-embedded@ozlabs.org; Sat, 07 Jun 2008 11:15:02 +0000
Received: from p5497fe98.dip.t-dialin.net ([84.151.254.152])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Sat, 07 Jun 2008 11:15:02 +0000
Received: from dzu by p5497fe98.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Sat, 07 Jun 2008 11:15:02 +0000
To: linuxppc-embedded@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: No console output when booting linux from uboot
Date: Sat, 07 Jun 2008 13:08:19 +0200
Message-ID: <m28wxh4i58.fsf@ohwell.denx.de>
References: <A9D89E0D76AFF24B9441851F2AC72D7203B7D468@BANMLVEM05.e2k.ad.ge.com>
	<m2hcc988n9.fsf@ohwell.denx.de>
	<A9D89E0D76AFF24B9441851F2AC72D7203BCB942@BANMLVEM05.e2k.ad.ge.com>
	<m2od6g6jxv.fsf@ohwell.denx.de>
	<A9D89E0D76AFF24B9441851F2AC72D7203C0DAAA@BANMLVEM05.e2k.ad.ge.com>
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

Hi Mike,

> Sorry for the confusing. I just figured out my problem is not for the
> Uboot version...
>
> As you suggested, I debuged the hw action related to serial driver
> today. I add the "console=ttyS2" in my uboot bootargs and corrected some
> part, but still no output yet. Is there other factors will affect the
> console output, except the serial driver?

Actually not that I can think of.  Depending on your driver, maybe the
default baud rate is not correct?  Did you try a "console=ttyS2,115200"
for example?

Cheers
  Detlev

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
