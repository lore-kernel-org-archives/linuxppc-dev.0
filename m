Return-Path: <g.jaeger@sysgo.com>
Received: from mailgate.sysgo.de (ns.sysgo.de [213.68.67.98])
	by ozlabs.org (Postfix) with ESMTP id C19052BDA5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Oct 2004 22:27:05 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mailgate.sysgo.de (Postfix) with ESMTP id 3125C47BBD
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Oct 2004 14:23:41 +0200 (CEST)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mailgate.sysgo.de (Postfix) with ESMTP id 2868E47BBD
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Oct 2004 14:23:41 +0200 (CEST)
Received: from kah.ulm.sysgo.com (firewall.sysgo.com [172.20.1.35])
	by donald.sysgo.com (Postfix) with ESMTP id C5AB4CEAE4
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Oct 2004 14:27:02 +0200 (CEST)
Received: from gja.ulm.sysgo.com (gja.ulm.sysgo.com [172.40.1.130])
	by kah.ulm.sysgo.com (8.9.3/8.8.8) with ESMTP id OAA06344
	for <linuxppc-embedded@ozlabs.org>; Fri, 22 Oct 2004 14:27:21 +0200
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 22 Oct 2004 14:27:02 +0200
References: <20041022085733.0c5289c8.Hiroshi_DOYU@montavista.co.jp>
	<20041022082955.GA27169@gate.ebshome.net>
	<006101c4b831$c3d60d30$0301a8c0@chuck2>
In-Reply-To: <006101c4b831$c3d60d30$0301a8c0@chuck2>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410221427.02301.g.jaeger@sysgo.com>
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

On Friday 22 October 2004 14:22, Mark Chambers wrote:
> > > this problem has been discussed a while ago between my co-worker and
> > > Matt-Porter - first on the list and later on in private. We also have this
> > > problem on a custom board using the 440GX. It can be also seen on a Ebony
> > > (440GP) as well and on our rather old Ocotea. Our kernel originally is
> > >based
> etc.
>
> I'm just curious here - I'm not familiar with IBM processors -
> is there a separate PHY chip, and if so, what is it?

Yes, on Ebony and Ocotea we have an AMD NetPHY AM79C875KC, on
Walnut, I'm not sure, on our custom boards we have also the AMD
and a NS DP83846A, as well as DP8385...

Gerhard
