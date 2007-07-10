Return-Path: <FENKES@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EF82ADDED0
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 23:20:14 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6ADKAuZ329978
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 13:20:10 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l6ADKAoQ2101394
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 15:20:10 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6ADK9tI001126
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 15:20:09 +0200
In-Reply-To: <adak5t9w7kx.fsf@cisco.com>
To: Roland Dreier <rdreier@cisco.com>
MIME-Version: 1.0
Subject: Re: [PATCH 00/13] IB/ehca: eHCA2 enablement & some fixes
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OF1EC84A1D.3C3D1851-ONC1257314.003EEB89-C1257314.00495729@de.ibm.com>
Date: Tue, 10 Jul 2007 15:20:08 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: LKML <linux-kernel@vger.kernel.org>, LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roland Dreier <rdreier@cisco.com> wrote on 10.07.2007 00:11:42:

> thanks, I applied these for 2.6.23 and fixed a bunch of minor things
> that scripts/checkpatch.pl complained about (since I was in a mood to
> do mindless things).

Thanks! Both for the quick merge and for the fixes!

> In the future please run that yourself and clean
> up the obvious things.  I generally don't worry about the 80 column
> stuff, but it will catch most whitespace problems and tell you that
> foo(x,y) should be foo(x, y) etc.  So you don't have to completely
> silence the script but at least take a look at the output.

Didn't know about that script before, so thanks for the pointer!
I'll be sure to pass the next set of patches through it.

Joachim
