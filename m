Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 516DEDDFCB
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 15:33:03 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l4V5WvEF012483
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 22:32:57 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l4V5Wr2a002953
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 00:32:54 -0500 (CDT)
Subject: Re: [PATCH v2]: Fix e500 v2 core reboot bug
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <e868acb03f9976b619eac6b988a10144@kernel.crashing.org>
References: <1180406209.8139.13.camel@localhost.localdomain>
	<BA0C2035-FCAD-4B34-A622-F79432079F10@kernel.crashing.org>
	<1180492466.12577.6.camel@localhost.localdomain>
	<A78C881D-26C3-4545-85CA-80C05085C039@kernel.crashing.org>
	<1180503967.12577.20.camel@localhost.localdomain>
	<19325B38-202C-4837-9BE8-0ACA482F2605@kernel.crashing.org>
	<976AFF56-7590-46B9-ADCA-4FA6673D4C9B@kernel.crashing.org>
	<e868acb03f9976b619eac6b988a10144@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1180589542.16155.21.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 31 May 2007 13:32:22 +0800
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

On Wed, 2007-05-30 at 23:21, Segher Boessenkool wrote:
> >> I'm thinking have a guts block and putting a property in it makes
> the
> >> most sense.
> >
> > After some discussion on IRC I think the following is the suggested 
> > node we should add in.
> >
> > guts@e00000 {
> >       compatible = "fsl,mpc8548-guts";
> >       reg = <e00000 1000>;
> >       fsl,has-rstcr;
> > };
> 
> Except you shouldn't call it "guts".

guts has a confused meaning :-)

How about
gub: global utility block
or 
guf: global utility feature
?
Any other idea?
Roy
