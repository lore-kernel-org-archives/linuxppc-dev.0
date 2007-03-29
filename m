Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 511A5DDE3C
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Mar 2007 05:22:36 +1000 (EST)
To: ganesh subramonian <gun_raj@yahoo.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: linuxppc_2_4_devel vs linux-2.6-denx 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 29 Mar 2007 00:13:34 PDT."
	<20070329071334.53837.qmail@web52401.mail.re2.yahoo.com>
Date: Thu, 29 Mar 2007 21:22:33 +0200
Sender: wd@denx.de
Message-Id: <20070329192233.C2250353A6C@atlas.denx.de>
Cc: linuxppc-mailing-list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <20070329071334.53837.qmail@web52401.mail.re2.yahoo.com> you wrote:
> 
> can someone tell me what is the difference between the git
> repositories linux-2.6-denx and linuxppc_2_4_devel ( other than that
> it is 2.4 vs 2.6 kernel). ...

Well, that's  a  pretty  significant  difference.  The  Linux  kernel
version  on which linuxppc_2_4_devel is based has been frozen about 3
years ago (a *very* long time for  Linux),  while  linux-2.6-denx  is
continuously kept in sync with the kernel.orc tree.

The linuxppc_2_4_devel contains a number of BSPs that have  not  been
proted  to  2.6 yet (and some of them never will), and vice versa the
linux-2.6-denx contains BSPs that are not supported by  the  old  2.4
kernel.

>                       ... Is there any difference in the processor
> families supported by these repositories? ...

Yes. Simply put: don't expect to find support for recent hardware  in
the old kernel tree.

>                                       ... Is it something like denx
> does not support 2.4 in the eldk??

ELDK up to and including version 3.1.1 is based  on  the  2.4  kernel
tree  in  the  linuxppc_2_4_devel  repository;  ELDK 4.0 and later is
based on the 2.6 kernel tree in the linux-2.6-denx repository.

> what gcc versions would be required to compile the 2.4 tree?

IT should be possible to compile it even with really  old  toolchains
like  gcc 2.95, altough we officially don't support this. GCC 3.x and
later should be fine (but avoid gcc 3.4.x  -  I've  seen  it  causing
problems in too many projects). Although you can use gcc-4.x from our
latest  ELDK  to  build  a 2.4 kernel, we recommend to use "matching"
toolchains, i. e. use ELDK 3.1.1 for linuxppc_2_4_devel (= 2.4) based
work, and use ELDK 4.1 for linux-2.6-denx (= 2.6) based projects.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
core error - bus dumped
