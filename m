Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id EA22067BD7
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Jul 2005 02:30:36 +1000 (EST)
Date: Wed, 6 Jul 2005 09:30:30 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Message-ID: <20050706163029.GC8358@smtp.west.cox.net>
References: <20050706051139.GB8358@smtp.west.cox.net>
	<20050706091200.5E060353A6A@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050706091200.5E060353A6A@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 2.6.12-rc2 netconsole problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jul 06, 2005 at 11:12:00AM +0200, Wolfgang Denk wrote:
> In message <20050706051139.GB8358@smtp.west.cox.net> you wrote:
> >
> > may want to look into a syslogd that does network.  I don't know how
> > netconsole support in u-boot works, but it sounds like it's a network
> > aware application that you can telnet into, rather than Linux's
> > netconsole.
> 
> It's an implementation which is compatible with  (and  derived  from)
> Linux'  netconsole,  but  with  an  added  input  channel so you have
> interactive control over ethernet.

That's quite cool.  Any chance that could be ported back to Linux (I
know netpoll supports it, kgdboe works in the kernel).

-- 
Tom Rini
http://gate.crashing.org/~trini/
