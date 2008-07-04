Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id B6020DDE23
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jul 2008 21:50:40 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KEjo7-0002wG-8m
	for linuxppc-embedded@ozlabs.org; Fri, 04 Jul 2008 11:50:31 +0000
Received: from p5497ff8e.dip.t-dialin.net ([84.151.255.142])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Fri, 04 Jul 2008 11:50:31 +0000
Received: from dzu by p5497ff8e.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Fri, 04 Jul 2008 11:50:31 +0000
To: linuxppc-embedded@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: Full Linux distributions
Date: Fri, 04 Jul 2008 13:48:53 +0200
Message-ID: <m2ej69vpi2.fsf@ohwell.denx.de>
References: <486D27B9.8090308@conceptxdesign.com>
	<c384c5ea0807031303i1ddf7663na80928fd77d40be5@mail.gmail.com>
	<486D32A7.7080007@conceptxdesign.com>
	<27dfa3d0807031659n4a03dd63i4793c3231d224ae6@mail.gmail.com>
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

Hi Daniel,

> I've been using the ELDK for an amcc440EP ppc board. It's turned out
> to be rather convenient, especially when running a networked
> environment. 

I'm glad to hear that the ELDK is useful.

> The guy who primarily maintains it is very helpful also.

To be honest, the ELDK is maintained by our company.  It has become too
much for a single individual.

We of course invite others from the community to get involved
here. There is a mailinglist[1] to discuss ELDK related topics and all
sources needed to build it are available from our git server[2].

One of the inconveniences preventing likely many attempts to get
involved is our old build system, which ensures excellent distribution
compatibility however.

So one of the first goals I try to invest spare time is to fix the build
process into being runnable on modern distros also.  We just cannot drop
support for the old build environment to be as widely compatible as
possible. 

Cheers
  Detlev

[1] http://lists.denx.de/mailman/listinfo/eldk
[2] http://git.denx.de/

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
