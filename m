Return-Path: <RAISCH@de.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1C5C7DDF13
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 02:52:13 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id lBCFq9nR046638
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 15:52:09 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id lBCFq9gI2801732
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 16:52:09 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id lBCFq88L032295
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 16:52:08 +0100
In-Reply-To: <475FD0A1.3090304@voltaire.com>
References: <OFD9564F75.44193623-ONC12573AE.002EA542-C12573AE.002F5FBC@de.ibm.com>
	<475FD0A1.3090304@voltaire.com>
Subject: Re: [ewg] Re: [PATCH] IB/ehca: Serialize HCA-related hCalls on POWER5
To: Or Gerlitz <ogerlitz@voltaire.com>
Message-ID: <OF2694B462.1504C1FC-ONC12573AF.0056AAC0-C12573AF.0056F862@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Wed, 12 Dec 2007 17:02:23 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Arnd Bergmann <arnd@arndb.de>, Roland Dreier <rdreier@cisco.com>,
	Joachim Fenkes <FENKES@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
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

Or Gerlitz <ogerlitz@voltaire.com> wrote on 12.12.2007 13:14:25:

> Joachim Fenkes wrote:
> > Roland Dreier <rdreier@cisco.com> wrote on 10.12.2007 22:47:37:
>
> >> It's an optional device feature, so this should be OK
> >> (although the iSER driver currently seems to depend on a device
> >> supporting FMRs, which is probably going to be a problem with iWARP
> >> support in the future anyway).
>
> > I don't feel very well with removing code from the driver that iSER
seems
> > to depend on. Are there plans to fix this in iSER?
>
> What is the fix you suggest, to add a device query that tells you for
> which verbs the documentation does not apply? or enhance the code of the
>   map_phys_fmr verb within the ehca driver to return error if called
> from non-sleepable context?

Roland,
what is your suggestion here?

We could implement both versions Or is proposing, but having both
at the same time sound like overkill.

Christoph R.
