Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id 7E8D6DDF0A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 May 2008 21:30:54 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K1gLD-0003nX-PO
	for linuxppc-embedded@ozlabs.org; Thu, 29 May 2008 11:30:43 +0000
Received: from p5497e4c6.dip.t-dialin.net ([84.151.228.198])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 29 May 2008 11:30:43 +0000
Received: from dzu by p5497e4c6.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 29 May 2008 11:30:43 +0000
To: linuxppc-embedded@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: Cross toolchain for ppc405 (virtex-4)
Date: Thu, 29 May 2008 13:29:32 +0200
Message-ID: <m23ao1gxgj.fsf@ohwell.denx.de>
References: <17515929.post@talk.nabble.com>
	<20080528171751.D545CBD8071@mail116-sin.bigfish.com>
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

Hi,

> I'm not sure on what version of gcc and glibc it's using, but I have been using
> ELDK 4.1 from denx.com. There are newer versions.

The more recent ELDK 4.2 supports 405s and its crosstoolchain uses
binutils 2.17.50.0.12, gcc 4.2.2, glibc 2.6 and gdb 6.7.

Cheers
  Detlev

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
