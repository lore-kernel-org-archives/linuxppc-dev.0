Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 21559DDED7
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 08:01:17 +1000 (EST)
Subject: Re: 2.6.27-rc1 problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <20080729175021.14c458ed@lappy.seanm.ca>
References: <20080729140617.7bf16aeb@lappy.seanm.ca>
	<1217367185.11188.260.camel@pasglop>
	<20080729175021.14c458ed@lappy.seanm.ca>
Content-Type: text/plain
Date: Wed, 30 Jul 2008 08:01:11 +1000
Message-Id: <1217368871.11188.267.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-29 at 17:50 -0400, Sean MacLennan wrote:
> On Wed, 30 Jul 2008 07:33:05 +1000
> "Benjamin Herrenschmidt" <benh@kernel.crashing.org> wrote:
> 
> > Yeah, sounds like it.
> 
> Thanks for the confirmation. Yeah, I think the git repository is
> corrupt. I did a git pull on a recently branched copy of this git and
> it was clean.

that's what git reset --hard is for... unless your objects are corrupt
too.

Ben.
