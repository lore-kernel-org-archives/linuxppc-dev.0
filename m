Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2F07DB7099
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Aug 2009 00:57:29 +1000 (EST)
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id B98E9DDD01
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Aug 2009 00:57:27 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MZQsg-0001CD-Tz
	for linuxppc-dev@ozlabs.org; Fri, 07 Aug 2009 14:57:18 +0000
Received: from p4ff04c67.dip.t-dialin.net ([79.240.76.103])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Fri, 07 Aug 2009 14:57:18 +0000
Received: from dzu by p4ff04c67.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Fri, 07 Aug 2009 14:57:18 +0000
To: linuxppc-dev@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: ethernet phy attached to wrong driver
Date: Fri, 07 Aug 2009 16:57:02 +0200
Message-ID: <m2y6pvu0xt.fsf@ohwell.denx.de>
References: <4A797655.6060205@gersys.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Stefan,

> I'm having trouble with my Ethernet device on a TQM5200 based board with
> LXT971 Phy. I'm running U-Boot 2009.03 and a Kernel 2.6.30.
>
> When doing a ping under U-Boot before booting into Linux, Ethernet works
> fine in Linux also. Dmesg reads:
> [  262.369444] net eth0: Using PHY at MDIO address 0
> [  263.265903] net eth0: attached phy 0 to driver LXT971
>
> But if I start Linux without prior use of the fec under U-Boot, Ethernet
> is not working in Linux. The wrong drivers seems to be attached to the
> phy. Dmesg reads:
> [    2.068285] net eth0: Using PHY at MDIO address 0
> [    2.964774] net eth0: attached phy 0 to driver Generic PHY
>                                                   ^^^^^^^^^^^
> Is there a bootarg to tell linux which driver to use? Any ideas what I'm
> doing wrong?

I cannot reproduce this problem with a tqm5200/stk52xx combination.
Linux always happily uses a genric PHY, irrelevant if I use networking
in U-Boot.

Cheers
  Detlev

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
