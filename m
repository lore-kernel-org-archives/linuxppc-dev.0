Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3FD5968802
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Dec 2005 11:02:28 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
In-Reply-To: <20051204224221.GA28218@hansmi.ch>
References: <111520052143.16540.437A5680000BE8A60000409C220076369200009A9B9CD3040A029D0A05@comcast.net>
	<70210ED5-37CA-40BC-8293-FF1DAA3E8BD5@comcast.net>
	<20051129000615.GA20843@hansmi.ch> <20051130223917.GA15102@hansmi.ch>
	<20051130234653.GB15102@hansmi.ch>
	<1133533712.23129.25.camel@localhost.localdomain>
	<20051204224221.GA28218@hansmi.ch>
Content-Type: text/plain
Date: Sat, 24 Dec 2005 10:59:44 +1100
Message-Id: <1135382385.4542.8.camel@gaston>
Mime-Version: 1.0
Cc: Parag Warudkar <kernel-stuff@comcast.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
Subject: Re: PowerBook5,8 - TrackPad update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok, I finally received my new laptop (PowerBook5,8 15"). I tried the
latest patch you posted, and while the kernel driver seem to work ok
(though you can feel the lack of a proper acceleration curve), the
synaptics driver in X doesn't work in any useable way. I updated the one
that comes with breezy to whatever was the latest on the author web site
(.44 I think) and while it detected the tracpkad, the result was soooooo
slooooow that it was totally unseable. I've tried the config tool that
comes with KDE for it but couldn't "boost" it to anything useful. Is
that expected or is there still issues to be resolved in the driver ?
I'm tempted to add some minimum support for a proper acceleration curve
in the kernel driver in fact...

Ben.
