Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4613FDDED6
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  5 Feb 2007 14:11:50 +1100 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HDuGU-0006dW-7i
	for linuxppc-embedded@ozlabs.org; Mon, 05 Feb 2007 04:11:35 +0100
Received: from dsl-202-45-109-210-static.VIC.netspace.net.au ([202.45.109.210])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Mon, 05 Feb 2007 04:11:34 +0100
Received: from daniel_ng11 by dsl-202-45-109-210-static.VIC.netspace.net.au
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Mon, 05 Feb 2007 04:11:34 +0100
To: linuxppc-embedded@ozlabs.org
From: Daniel Ng <daniel_ng11@lycos.com>
Subject: Re: ELDK glibc =?utf-8?b?ZmNudGwoc29ja2V0RmQsCUZfU0VURkws?= flags)
	causes Seg Fault
Date: Mon, 5 Feb 2007 03:11:20 +0000 (UTC)
Message-ID: <loom.20070205T040856-192@post.gmane.org>
References: <loom.20070201T073939-302@post.gmane.org>
	<20070202073018.C8710352B86@atlas.denx.de>
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

Thanks for your help everyone, I figured it out.

The cause of the problem seems to be unrelated to the F_SETFL- it just happened 
to seg fault at that point all the time.

Cheers,
Daniel
