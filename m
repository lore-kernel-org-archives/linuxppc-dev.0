Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id BEF4367B1F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Apr 2005 02:36:14 +1000 (EST)
Date: Thu, 7 Apr 2005 09:36:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
Message-ID: <20050407163607.GN3396@smtp.west.cox.net>
References: <f476b44c655d9125f95b6d3ddc225576@embeddededge.com>
	<DCEAAC0833DD314AB0B58112AD99B93B85933A@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B85933A@ismail.innsys.innovsys.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: FCC Ethernet startup crash
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Apr 05, 2005 at 01:53:36PM -0500, Rune Torgersen wrote:
> > From: Dan Malek [mailto:dan@embeddededge.com] 
> > On Apr 5, 2005, at 12:41 PM, Rune Torgersen wrote:
> > 
> > > Without calling fcc_restart in the start, I get lots of 
> > "eth0: tx queue
> > > full!." messages.
> > 
> > Do you tftp boot your kernel using the boot rom?  Does the
> > boot rom disable the Ethernet before calling the kernel?
> 
> Yes, I tftp the kernel, using U-Boot (1.1.2 CVS Head as of 11-20-04).
> Haven't looked at the code, but I think it disablesd the FCC Ethernets
> (Have seen discussions about htat on u-boot mailing list before)
> 
> The patch Stefan Nickl gave to me works perfectly, and all it does is
> basically move the fcc_restart.
> The kernel was still calling fcc_restart twiche per FCC at startup (one
> time on init_fcc_startup, and then again in fcc_open), now it just calls
> it twice in fcc_open. Seems to work.

Would someone please post what's needed vs current'ish 2.6 so we can get
the proper fix up & in? :)  With the Signed-off-by & all that.. Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
