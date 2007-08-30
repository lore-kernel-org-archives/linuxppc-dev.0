Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2E3A0DDE2B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Aug 2007 19:53:29 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IQgiC-0008D4-AG
	for linuxppc-embedded@ozlabs.org; Thu, 30 Aug 2007 11:53:16 +0200
Received: from p5497eb40.dip.t-dialin.net ([84.151.235.64])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 30 Aug 2007 11:53:16 +0200
Received: from dzu by p5497eb40.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 30 Aug 2007 11:53:16 +0200
To: linuxppc-embedded@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: how to debug the linux kernel with a BDI2000
Date: Thu, 30 Aug 2007 11:52:10 +0200
Message-ID: <m2hcmhfiyd.fsf@ohwell.denx.de>
References: <479723497.472031188208291804.JavaMail.coremail@bj163app103.163.com>
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

Hi Denny,

> My kernel hanged in when passed the parameters to it, and I dump nothing from
> the log_buf, so I guss it is crashed at the very beginning.
>  
> however I didn't know how to setup the KDB to load the kernel with the BDI2000
> ethernet? is there anyone has even loaded and debugged the kernel with the
> BDI2000 ethernet? if so pls show me how it goes?

You don't need KDB to use the BDI2000 to debug a linux kernel, in fact
you need nothing on the target side.  Simply attach the BDI to your
hardware, and use a (cross-)gdb with the "target remote
<ipaddr>:<port>" command.  Our DULG shows how to do that with
U-Boot[1].  Debugging (static) Linux is exactly the same...

Cheers
  Detlev

[1] http://www.denx.de/wiki/view/DULG/DebuggingUBoot

-- 
debian is a prototype for a future version of emacs.
                         -- Thien-Thi Nguyen in <7eekubiffq.fsf@ada2.unipv.it>
--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
