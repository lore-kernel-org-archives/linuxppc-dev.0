Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3BE322BDA5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Oct 2004 18:30:01 +1000 (EST)
Date: Fri, 22 Oct 2004 01:29:55 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Gerhard Jaeger <g.jaeger@sysgo.com>
Message-ID: <20041022082955.GA27169@gate.ebshome.net>
References: <20041022085733.0c5289c8.Hiroshi_DOYU@montavista.co.jp>
	<20041022103859.50e2b2f6.Hiroshi_DOYU@montavista.co.jp>
	<20041022020226.GC22069@gate.ebshome.net>
	<200410220826.40794.g.jaeger@sysgo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200410220826.40794.g.jaeger@sysgo.com>
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

On Fri, Oct 22, 2004 at 08:26:40AM +0200, Gerhard Jaeger wrote:
> 
> this problem has been discussed a while ago between my co-worker and
> Matt-Porter - first on the list and later on in private. We also have this
> problem on a custom board using the 440GX. It can be also seen on a Ebony
> (440GP) as well and on our rather old Ocotea. Our kernel originally is based
> on 2.4.26, but the EMAC driver has been backported from 2.6.9.
> Fiddling around with some settings seems to help a bit, but in the end we see
> excessive collisions. The reason is not clear yet. 
> Matt could not confirm this behaviour 'til now.

Hmm, did you see problems on 100 HDX as well, or only on 10 HDX?

FWIW, I haven't seen any problems when testing my new EMAC driver with 
100Mb hub, maybe it's only 10Mb related.

Anyway, this is first time I'm hearing about half duplex problems, 
Matt just mentioned them on IRC to me.

I'll try to do some tests this weekend, although I have to admit half 
duplex doesn't seem very important these days, nevertheless, if this 
can be fixed, we better do this :).

--
Eugene
