Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 3E702DDEE6
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Mar 2007 03:03:18 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l2NG3FKC000094
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 09:03:15 -0700 (MST)
Subject: Re: [PATCH] Remove bogus errors from check_chosen.
From: Jon Loeliger <jdl@freescale.com>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20070323150517.GB6060@ld0162-tx32.am.freescale.net>
References: <20070322161109.GA20512@ld0162-tx32.am.freescale.net>
	<20070323033158.GG28006@localhost.localdomain>
	<20070323150517.GB6060@ld0162-tx32.am.freescale.net>
Content-Type: text/plain
Message-Id: <1174665793.32390.73.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Fri, 23 Mar 2007 11:03:13 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-03-23 at 10:05, Scott Wood wrote:
> On Fri, Mar 23, 2007 at 02:31:58PM +1100, David Gibson wrote:
> > I'm not 100% comfortable with this patch; I'd like for dtc to have the
> > facility to do more-or-less complete tree validation.
> 
> That'd be nice as long as it's optional; it should be possible to do a
> low level dts->dtb transformation without the tool assuming that the
> output is intended to be a final, valid tree with the specific bindings
> that dtc knowns about (or even an OF-ish tree at all).
> 
> -Scott

So, how about adding a "--complete" or "--final"
sort of flag an having it:

    - Enforce presence of /chosen
    - Disallowing the proposed [ ? ? ? ? ] indicators
    - Uh, other stricter checking...

jdl
