Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4E8842BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  8 Nov 2004 13:55:17 +1100 (EST)
Date: Sun, 7 Nov 2004 18:55:04 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Gerhard Jaeger <g.jaeger@sysgo.com>
Message-ID: <20041108025504.GA4112@gate.ebshome.net>
References: <20041022085733.0c5289c8.Hiroshi_DOYU@montavista.co.jp>
	<20041022082955.GA27169@gate.ebshome.net>
	<20041025011654.GA3290@gate.ebshome.net>
	<200410250847.00907.g.jaeger@sysgo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200410250847.00907.g.jaeger@sysgo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [BUG] IBM440GX works too slow under nfsroot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Oct 25, 2004 at 08:47:00AM +0200, Gerhard Jaeger wrote:
> > If there is an interest, I can make a patch against current 2.4 BK
> > tree, but this will take some time (I'm a little swamped right now).
> 
> of course there's some interest, at least by me ;) Would be great if you'll
> find some time for that.

Patch against current 2.4 BK is available at http://kernel.ebshome.net. 
Quick tested on Ebony & Ocotea.

--
Eugene
