Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D7594B7B98
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Sep 2009 20:49:24 +1000 (EST)
Subject: Re: time jumps forward/backwards
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Benjamin Gamsa <ben@somanetworks.com>
In-Reply-To: <4A9C9BA3.6020105@somanetworks.com>
References: <4A9C465D.4010801@somanetworks.com>
	<19100.24755.889091.412993@cargo.ozlabs.ibm.com>
	<4A9C6446.2000202@somanetworks.com>	<4A9C664D.6010504@somanetworks.com>
	<4A9C84D0.8040200@somanetworks.com>
	<20090831223111.7b2dc95d@lappy.seanm.ca>
	<4A9C9BA3.6020105@somanetworks.com>
Content-Type: text/plain
Date: Tue, 01 Sep 2009 20:49:14 +1000
Message-Id: <1251802154.14675.346.camel@pasglop>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-08-31 at 23:57 -0400, Benjamin Gamsa wrote:
> Sean MacLennan wrote:
> > On Mon, 31 Aug 2009 22:20:00 -0400
> > Benjamin Gamsa <ben@somanetworks.com> wrote:
> > 
> >> For what it's worth, the problem occurs even when ntp is not even
> >> started.
> > 
> > This is grasping, but could it have anything to do with the jiffies
> > wrapping near startup?
> > 
> 
> I don't know how to test it, but I don't think so, since there are 
> multiple of these glitches over an extended period of time.

I'm not familiar with all the FSL processor variants, but is this
an UP or an SMP platform ? In the later case, are all the core timebases
properly synchronized ?

Cheers,
Ben.
