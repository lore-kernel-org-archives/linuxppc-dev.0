Return-Path: <RAISCH@de.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1DD9667B52
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 00:21:01 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.7/8.13.7) with ESMTP id k7IEKuv8037294
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 14:20:56 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7IEOp4L153502
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 16:24:51 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7IEKuqN030991
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 16:20:56 +0200
In-Reply-To: <200608181547.47081.arnd.bergmann@de.ibm.com>
Subject: Re: [2.6.19 PATCH 3/7] ehea: queue management
To: abergman@de.ibm.com
Message-ID: <OFC184057C.C58732A2-ONC12571CE.004E5EF6-C12571CE.004ED1D4@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Fri, 18 Aug 2006 16:24:48 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Thomas Q Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Marcus Eder <meder@de.ibm.com>,
	tklein@linux.ibm.com, Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> You should really do some measurements to see what the minimal
> queue sizes are that can get you optimal throughput.
>
>    Arnd <><

we did.
And as always in performance tuning... one size fits all unfortunately is
not the correct answer.
Therefore we'll leave that open to the user as most other new ethernet
driver did as well.

Regards . . . Christoph R
