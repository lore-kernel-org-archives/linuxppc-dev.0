Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F0B93DDEC8
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Jun 2007 00:31:45 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HvwXe-0004fm-6I
	for linuxppc-embedded@ozlabs.org; Wed, 06 Jun 2007 16:31:18 +0200
Received: from p5497d858.dip.t-dialin.net ([84.151.216.88])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 06 Jun 2007 16:31:18 +0200
Received: from dzu by p5497d858.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 06 Jun 2007 16:31:18 +0200
To: linuxppc-embedded@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: memory issue on ppc
Date: Wed, 06 Jun 2007 16:30:51 +0200
Message-ID: <m2odjtyx2c.fsf@sowhat.denx.de>
References: <200706060834.l568YTvM018140@lords.patni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Sekhar,

>         I m working on  powerpc and new to linux . wrote a small program where
> I allocate memory for 100, 1000 ,10000 bytes and memset them to zero . when I
> allocate to more than 8108 bytes and memset to zero it fails . but when I
> memset to any other ASCII value it passes . can u help me out as I m stuck with
> it for a long time . is there any problem with the library ?

My crystal ball is out of order right now so I would need some more
details to answer.

Please post the code and tell us on what platform and with which
kernel version, gcc version, etc. you are working.

Cheers
  Detlev

-- 
   "Our enemies  are innovative  and resourceful, and so are we.  They
never stop thinking about new ways to harm our country and our people,
and neither do we."
       -- George W. Bush during a defense bill ceremony on 5. Aug 2004
--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
