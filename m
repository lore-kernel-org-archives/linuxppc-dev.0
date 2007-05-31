Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DE873DDFCE
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 15:52:19 +1000 (EST)
Subject: Re: [PATCH v2]: Fix e500 v2 core reboot bug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
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
Date: Thu, 31 May 2007 15:52:11 +1000
Message-Id: <1180590732.19517.338.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Wed, 2007-05-30 at 17:21 +0200, Segher Boessenkool wrote:
> >> I'm thinking have a guts block and putting a property in it makes the
> >> most sense.
> >
> > After some discussion on IRC I think the following is the suggested 
> > node we should add in.
> >
> > guts@e00000 {
> > 	compatible = "fsl,mpc8548-guts";
> > 	reg = <e00000 1000>;
> > 	fsl,has-rstcr;
> > };
> 
> Except you shouldn't call it "guts".

You prefer "bowels" ? :-)

Ben.
