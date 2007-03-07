Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2D2EFDDF05
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Mar 2007 22:06:30 +1100 (EST)
Subject: Re: PROBLEM: 2.6.20-1 not working on ibook g4 (BUG/Oops)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Collins <paul@briny.ondioline.org>
In-Reply-To: <873b4h64dm.fsf@briny.internal.ondioline.org>
References: <200703051414.15802.frafore@tiscali.it>
	<1173143894.3461.240.camel@pmac.infradead.org>
	<87tzwzqgrx.fsf@briny.internal.ondioline.org>
	<1173177329.3461.291.camel@pmac.infradead.org>
	<873b4h64dm.fsf@briny.internal.ondioline.org>
Content-Type: text/plain
Date: Wed, 07 Mar 2007 12:04:39 +0100
Message-Id: <1173265479.9349.51.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: francesco foresti <frafore@tiscali.it>,
	David Woodhouse <dwmw2@infradead.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-03-07 at 17:53 +1300, Paul Collins wrote:
> David Woodhouse <dwmw2@infradead.org> writes:
> 
> > On Tue, 2007-03-06 at 14:53 +1300, Paul Collins wrote:
> >> In case it's of interest, 2.6.20 has been running fine on my
> >> PowerBook5,4. 
> >
> > How much memory? What if you boot with mem=512M or mem=256M?
> 
> 1GB.  Also works fine when booted with those options.

Can you try 2.6.21-rc3 ? We just fixed a nasty bug causing memory
corruption.

Ben.
