Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 76272DE15E
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 02:09:56 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JlRFe-0005uq-Pc
	for linuxppc-dev@ozlabs.org; Mon, 14 Apr 2008 16:09:50 +0000
Received: from p5497db12.dip.t-dialin.net ([84.151.219.18])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Apr 2008 16:09:50 +0000
Received: from dzu by p5497db12.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Apr 2008 16:09:50 +0000
To: linuxppc-dev@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: Signal backtrace function
Date: Mon, 14 Apr 2008 18:09:00 +0200
Message-ID: <m2skxoo1ur.fsf@ohwell.denx.de>
References: <1207764980.5826.77.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jocke,

> I made my own backtrace function for printing
> a trace from within a signal handler. Maybe it
> can be useful for the kernel too? General
> comments welcome.

Probably a dumb question, but doesn't backtrace(3) from glibc work
architecture independent already?   Why do you need to reimplement it?

Thanks
  Detlev

-- 
The management question  ...  is not  _whether_  to build a pilot system
and throw it away.  You _will_ do that.  The only question is whether to
plan  in advance  to build  a throwaway,  or  to promise  to deliver the
throwaway to customers.          - Fred Brooks, "The Mythical Man Month"
--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
