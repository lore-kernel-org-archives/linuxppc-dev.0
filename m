Return-Path: <FENKES@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 89693DDE39
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 19:08:00 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id l8Q97uhN132436
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 09:07:56 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l8Q97u8G2347238
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 11:07:56 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l8Q97tJD028099
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 11:07:55 +0200
In-Reply-To: <200709251627.59040.arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
MIME-Version: 1.0
Subject: Re: [PATCH 1/5] PowerPC: Move of_device allocation into of_device.[ch]
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OF0943F46C.2CC5F9D0-ONC1257362.0031D840-C1257362.003229B6@de.ibm.com>
Date: Wed, 26 Sep 2007 11:07:54 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: Thomas Q Klein <tklein@de.ibm.com>, Paul Mackerras <pmac@au1.ibm.com>,
	Jan-Bernd Themann <themann@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Christoph Raisch <raisch@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann <arnd@arndb.de> wrote on 25.09.2007 16:27:57:

> The patch looks good to me, especially since you did exactly what I
> suggested ;-)

Yes, our discussions were very productive. Thanks and sorry I forgot to 
mention your input.
 
> Maybe the description should have another sentence in it about what
> the change is good for. You have that in the 0/5 mail, but that does
> not go into the changelog, so the information gets lost in the process.

Can do. New patch coming right up!

Joachim
