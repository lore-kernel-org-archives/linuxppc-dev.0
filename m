Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EAB2CDDD0D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Jul 2007 17:51:01 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IFmVI-00027S-9o
	for linuxppc-embedded@ozlabs.org; Tue, 31 Jul 2007 09:50:52 +0200
Received: from p54a4cfa3.dip.t-dialin.net ([84.164.207.163])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 31 Jul 2007 09:50:52 +0200
Received: from mls.JOFT by p54a4cfa3.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 31 Jul 2007 09:50:52 +0200
To: linuxppc-embedded@ozlabs.org
From: Joachim =?ISO-8859-1?Q?F=F6rster?= <mls.JOFT@gmx.de>
Subject: Re: ml403 ac97 driver
Date: Tue, 31 Jul 2007 09:50:40 +0200
Message-ID: <1185868239.5527.9.camel@localhost>
References: <1185698888.6397.37.camel@localhost>
	<11858308.post@talk.nabble.com> <1185780815.5454.18.camel@localhost>
	<11859770.post@talk.nabble.com>  <11918008.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain
In-Reply-To: <11918008.post@talk.nabble.com>
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

Hi Qin Lin,

On Mon, 2007-07-30 at 21:22 -0700, Qin Lin wrote:
> 1.add the lm4550 driver to kernel source
> (someboby may can add them as a patch to kernel source)

In fact, in the last few days, I worked on my driver, made changes
according to Grant Likely's list of comments (see the thread where I
announced the driver). And right now, I'm preparing a patch against the
official kernel tree. So, I'll post a patch soon myself - just view more
days.

 Joachim
