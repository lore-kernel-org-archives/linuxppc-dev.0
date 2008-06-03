Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id E7552DE57B
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Jun 2008 22:24:48 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K3VZC-0000RK-2C
	for linuxppc-embedded@ozlabs.org; Tue, 03 Jun 2008 12:24:42 +0000
Received: from p5497f0cc.dip.t-dialin.net ([84.151.240.204])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 03 Jun 2008 12:24:42 +0000
Received: from dzu by p5497f0cc.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 03 Jun 2008 12:24:42 +0000
To: linuxppc-embedded@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: Timer task synchronization
Date: Tue, 03 Jun 2008 14:23:31 +0200
Message-ID: <m2k5h6emgs.fsf@ohwell.denx.de>
References: <48401111.1060703@globaledgesoft.com>
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

Hi Spoorthi,

>    I am dealing with timer synchronization problem.. we have two timer
> threads. The two timers are started one after the other. The first
> timer timeout value is 10s and the second timer tiemout value is 15s.
>
> The first timer fires after 10s and the timer thread is suspended
> until the second timer completes its task. once the second timer is
> done the first timer resumes.
>
> sometimes the first timer resumes back even before the second timer
> starts and blocks the second timer thread..

Reading your text, I have to admit, I have no idea whether you talk
about kernel threads, or posix threads and thus about kernel timers or
user space timers?

Without giving any more detail on what you try to do, and especially,
where you think the system does not behave as you would expect it,
nobody will be able to help you here.  Best of course is to show us some
stripped down code that exposes what you think is the problem.

Apart from that I guess that you somehow have synchronization problems
not directly related to timers at all, but that's just a gut feeling.

Cheers
  Detlev

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
