Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id C7BDCDE602
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Jul 2008 04:28:17 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KE73r-0008AN-5L
	for linuxppc-embedded@ozlabs.org; Wed, 02 Jul 2008 18:28:11 +0000
Received: from p5497c006.dip.t-dialin.net ([84.151.192.6])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 02 Jul 2008 18:28:11 +0000
Received: from dzu by p5497c006.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 02 Jul 2008 18:28:11 +0000
To: linuxppc-embedded@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: Updating glibc on SELF image
Date: Wed, 02 Jul 2008 20:26:34 +0200
Message-ID: <m2hcb82ld1.fsf@ohwell.denx.de>
References: <1213824912.4450.20.camel@localhost.localdomain>
	<1213901149.4450.22.camel@localhost.localdomain>
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

Hi Dave,

> Can someone provide a comprehensive guide for building SELF images from
> scratch? More specifically how to install dependency libraries?

There is a mailing list specifically for ELDK and related questions[1].  

Apart from that, if you want to change SELF contents, you can either do
it manually (as you started) or adjust the SELF spec file and rebuild
the target RPM as documented in the DULG.

Apart from that I believe you somehow work with mismatching SELF and
ELDK NFS installations.  The SELF rpm is built from the ELDK NFS
installation, so it is simply not possible to have different versions of
libraries between those two.

Cheers
  Detlev

[1] http://lists.denx.de/mailman/listinfo/eldk

-- 
Ftpd never switches uid and euid, it uses setfsuid(2) instead. The
main reason is that uid switching has been exploited in several
breakins, but the sheer ugliness of uid switching counts too.
                                     -- pure-ftpd(8)
