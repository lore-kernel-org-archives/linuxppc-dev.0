Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E13192BDB5
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Nov 2004 18:12:16 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Armando Di Cianno <fafhrd@gentoo.org>
In-Reply-To: <2101489e3424befc4c73bd04bbebaa25@nephiliah>
References: <2101489e3424befc4c73bd04bbebaa25@nephiliah>
Content-Type: text/plain
Date: Sun, 21 Nov 2004 18:11:31 +1100
Message-Id: <1101021091.27157.65.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: TEST: Sleep suppport for iBook G4 & Aluminium PowerBooks (ATI
	based)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2004-11-20 at 22:00 -0500, Armando Di Cianno wrote:

> Using 'NoAccel' in xorg.conf seems to hide the symptoms of the bug, or 
> remove the bug.
> 
> However, without that option, with this patch, the problem seems "less 
> bad", if that's even possible.  It takes longer for the root window to 
> get "ridiculously speckled."  Not sure if that info helps at all. :-)
> 
> Not sure if I mentioned that, the first patch (the one sent a couple 
> weeks ago) did not seem to have this problem.

Yes, you did mention it, which is weird. I'll have to spend some time
comparing the 2 versions and see if I can spot something.

Ben
