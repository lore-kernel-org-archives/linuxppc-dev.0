Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 54D9CDDDFA
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 17:26:31 +1100 (EST)
Subject: Re: [PATCH 1/2] firewire: endianess fix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jarod Wilson <jwilson@redhat.com>
In-Reply-To: <200802272221.38985.jwilson@redhat.com>
References: <20080220220326.GA22328@uranus.ravnborg.org>
	<200802271458.28401.jwilson@redhat.com>
	<1204166422.15052.334.camel@pasglop>
	<200802272221.38985.jwilson@redhat.com>
Content-Type: text/plain
Date: Thu, 28 Feb 2008 17:25:59 +1100
Message-Id: <1204179959.15052.372.camel@pasglop>
Mime-Version: 1.0
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Stefan Richter <stefanr@s5r6.in-berlin.de>,
	sparclinux@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	Sam Ravnborg <sam@ravnborg.org>,
	Harvey Harrison <harvey.harrison@gmail.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Under Mac OS X, system.log says "FireWire (OHCI) Apple ID 31 built-in now 
> active". Could still be lucent though, judging by the subsys device ID of 
> 5811, which matches up w/the Lucent/Agere FW323. But no, apparently I don't 
> have the interesting one.

Well, it's interesting in the sense that it's a "normal" OHCI then on a
BE machine :-) My Pismo, which had the weirdo one, unfortunately died a
while ago. I'll see if I can find another machine with that one in.

Cheers,
Ben.
