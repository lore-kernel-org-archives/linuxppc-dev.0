Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id 334EFDDE98
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Sep 2008 20:56:02 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KaTY8-0001XB-4i
	for linuxppc-embedded@ozlabs.org; Tue, 02 Sep 2008 10:55:52 +0000
Received: from p5497fc34.dip.t-dialin.net ([84.151.252.52])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 02 Sep 2008 10:55:52 +0000
Received: from dzu by p5497fc34.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 02 Sep 2008 10:55:52 +0000
To: linuxppc-embedded@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: Compile new kernel for 5200B w/ ELDK
Date: Tue, 02 Sep 2008 12:55:23 +0200
Message-ID: <m2tzcyhl5w.fsf@ohwell.denx.de>
References: <1219770125l.5709l.0l@antares> <m2bpz8j5bw.fsf@ohwell.denx.de>
	<67480A61D7CE4641B90CDD3C58C7AEC77387F9@CHN-HCLT-EVS02.HCLT.CORP.HCL.IN>
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

Hi Rajasekaran,

>      Am working with PowerPc 8315rdb...and ma using recend version of
> the kernel 2.6.26..but I found one problem with RTC m41t11..while trying
> to read or set RTC which is already opened while booting itself,,,its
> return the error message as resourse busy  with error no 29.. can u help
> me to solve this issue,,,

Actually, I cannot help you right now, as I do not understand the
problem.  Can you perhaps show some log files and source code exhibiting
the problem?

What exactly are you trying to do?  Did you try enabling RTC_DEBUG in
the configuration (Device Drivers -> Real Time Clock -> RTC Debug
support)?  What do the kernel messages look like?

Cheers
  Detlev

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
