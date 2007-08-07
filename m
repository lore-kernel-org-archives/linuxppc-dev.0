Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	by ozlabs.org (Postfix) with ESMTP id 06887DDEA3
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Aug 2007 05:21:18 +1000 (EST)
To: Michael Brian Willis <willis@arlut.utexas.edu>
Subject: Re: Fedora 7 on a non FPU system
References: <20070313043050.GB82243@server.idefix.lan>
	<513703.69187.qm@web302.biz.mail.mud.yahoo.com>
	<20070314043305.GB27011@server.idefix.lan>
	<20070314065411.GD14658@moe.telargo.com>
	<1186508561.5592.26.camel@louie>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 07 Aug 2007 12:11:21 -0700
In-Reply-To: <1186508561.5592.26.camel@louie> (Michael Brian Willis's message
	of "Tue, 07 Aug 2007 12:42:41 -0500")
Message-ID: <adawsw7rwh2.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 > Has anybody every successfully installed Fedora(or another major distro)
 > on a non-FPU system? Or, does anybody know what is needed to get it
 > working properly on a non FPU system? 

The simplest thing to do is to use a kernel that has FPU emulation
enabled.  Pretty much every ppc binary will use the FPU for spare
registers if nothing else, so your only other alternative would be to
rebuild the whole distribution.

 - R.
