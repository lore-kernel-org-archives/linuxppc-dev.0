Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id 57A06DDF4C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Sep 2008 20:02:21 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KaSiG-0007dO-9M
	for linuxppc-embedded@ozlabs.org; Tue, 02 Sep 2008 10:02:16 +0000
Received: from p5497fc34.dip.t-dialin.net ([84.151.252.52])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 02 Sep 2008 10:02:16 +0000
Received: from dzu by p5497fc34.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 02 Sep 2008 10:02:16 +0000
To: linuxppc-embedded@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: MPC8568MDS RAMDISK Problem
Date: Tue, 02 Sep 2008 12:01:49 +0200
Message-ID: <m2y72ahnn6.fsf@ohwell.denx.de>
References: <931ae8260809010218u33b4a42aga6c6359d792deeca@mail.gmail.com>
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

>  Hi:
>      ram0: rw=0, want=1345772050, limit=1000000, this error cause by
> Device Drivers->block device-> ramdisk size
>      make ramdisk size bigger~~~~
> regards:)
> yanlong

One can also use the "ramdisk_size" command line parameter
(cf. Documentation/kernel-parameters.txt).  It is not neccessary to
recompile the kernel for that.

Cheers
  Detlev

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
