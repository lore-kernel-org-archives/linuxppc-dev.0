Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8239767B4C
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Jun 2005 09:24:42 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <42A0E640.4020304@am.sony.com>
References: <42A0E640.4020304@am.sony.com>
Content-Type: text/plain
Date: Sat, 04 Jun 2005 09:23:32 +1000
Message-Id: <1117841012.31082.191.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] [1/2] PM support for Ebony
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2005-06-03 at 16:22 -0700, Geoff Levand wrote:
> I rebased this to apply to Benjamin's ppc32-rework-pm.diff, but 
> didn't recode it to take advantage of the extra hooks.  More work 
> is certainly needed for wake-on-lan.  Any comments on improvement 
> would be most welcome.
> 
> I could also make one available against a 2.6.12-rc if requested.

Ok, well, part of the issue here is that I'm about to rework the
rework ... I discussed with Pat Mochel, and we are about to kill pm_ops
completely and have the code structured differently. Instead of hooks,
have the arch code be called on state change and be "in charge".

I'll try to setup an Ebony here asap so I can keep your patches in sync
as well.

Ben.
