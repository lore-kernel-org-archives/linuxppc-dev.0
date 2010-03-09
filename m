Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by ozlabs.org (Postfix) with ESMTP id 3085FB7D11
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Mar 2010 04:31:18 +1100 (EST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glppd-linuxppc64-dev@m.gmane.org>)
	id 1Np2x1-0003Zc-3a
	for linuxppc-dev@ozlabs.org; Tue, 09 Mar 2010 18:10:35 +0100
Received: from p4ff0552a.dip.t-dialin.net ([79.240.85.42])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Mar 2010 18:10:35 +0100
Received: from dzu by p4ff0552a.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Mar 2010 18:10:35 +0100
To: linuxppc-dev@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: cross-compiling Linux for PowerPC e200 core?
Date: Tue, 09 Mar 2010 15:24:57 +0100
Message-ID: <m2y6i1h8sm.fsf@ohwell.denx.de>
References: <4B934CCA.8030608@freemail.hu>
	<9859E645-954D-4D07-8003-FFCD2391AB6E@kernel.crashing.org>
	<4B9546CD.1000008@freemail.hu>
	<53452.84.105.60.153.1268080871.squirrel__48847.2990495667$1268080944$gmane$org@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Segher,

> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=33d9e9b
>
> There is no obvious way to get there via clicking afaics, the "commit"
> search box doesn't work at least.  Hrm.

It works, but not like one would expect, i.e. check out the help:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=search_help

Last I checked the gitweb code, there was no easy way other than what
you did by manipulating the URL directly.

Cheers
  Detlev

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
