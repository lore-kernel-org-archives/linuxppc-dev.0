Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 218AEDDE06
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 12:16:50 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l552GHo8028779
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 19:16:45 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l552GF1L023392
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 21:16:16 -0500 (CDT)
Subject: Re: [PATCH v2]: Fix e500 v2 core reboot bug
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <c6f611e5eaff31a78979752ecd49e5f2@kernel.crashing.org>
References: <1180406209.8139.13.camel@localhost.localdomain>
	<BA0C2035-FCAD-4B34-A622-F79432079F10@kernel.crashing.org>
	<1180492466.12577.6.camel@localhost.localdomain>
	<A78C881D-26C3-4545-85CA-80C05085C039@kernel.crashing.org>
	<1180503967.12577.20.camel@localhost.localdomain>
	<19325B38-202C-4837-9BE8-0ACA482F2605@kernel.crashing.org>
	<976AFF56-7590-46B9-ADCA-4FA6673D4C9B@kernel.crashing.org>
	<1180945726.10048.0.camel@localhost.localdomain>
	<dc4e7ef8f03da79b9322f21b8b82c6d9@kernel.crashing.org>
	<1180947682.10048.23.camel@localhost.localdomain>
	<c6f611e5eaff31a78979752ecd49e5f2@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1181009746.10048.42.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 05 Jun 2007 10:15:47 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-06-04 at 18:37, Segher Boessenkool wrote:
> >>>> guts@e00000 {
> 
> >> If "guts" is some kind of official name (i.e., the
> >> block is called that in the user manual), it looks
> >> okay to me.
> > No! It is not official name. It is provided by Kumar. It should be a
> > abbr. standing for "Global Utilities" as far as my understand.
> 
> So the official name is "global utilities block"?
> 
> >> Otherwise, please change; in fact, just
> >> change the name anyway (not the compatible), to
> >> "shared-soc-regs" or something like that;
> > I can not agree with you. "shared-soc-regs" can not describe the
> > property of this kind of register.
> > The official description for this set of registers:
> >
> > "The global utilities block controls power management, I/O device
> > enabling, power-on-reset (POR) configuration monitoring, 
> > general-purpose
> > I/O signal configuration, alternate function selection for
> multiplexed
> > signals, and clock control.
> >
> > gub (Kumar's style?): global utilities block
> > or
> > global-uti-regs or global-uti (Segher's style?)
> > may be better.
> 
> "global-utilities" sounds fine to me, although the
> name doesn't actually say anything.  Let's avoid
> abbr.s unless they are very widely known.
"global-utilities" seems good to me!
> 
> >>  "name"
> >> should be descriptive (but terse).
> >>
> > Agree!
> > But we should reach a agreement!
> 
> Nah, you guys just need to come up with a good name :-)
> I would just call it "control" perhaps ;-)
> 
> It doesn't matter much, but "name" should be human-
> readable, human-understandable, and short.  A made-up
> acronym doesn't work (although I like "guts", sure --
> put it in your "compatible" property ;-) )
Agree!
Thanks.
Roy
