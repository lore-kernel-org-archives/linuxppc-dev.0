Return-Path: <RAISCH@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C28CEDDE1E
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Sep 2008 20:43:27 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id m8IAgBdh426012
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Sep 2008 10:42:11 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m8IAgAC44165780
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Sep 2008 12:42:10 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m8IAg7cs027134
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Sep 2008 12:42:07 +0200
In-Reply-To: <20080918112713.75872c95@bull.net>
References: <20080915100406.342e027a@bull.net>	<OF39C3BF0F.17B60FAA-ONC12574C8.002AE138-C12574C8.002B6422@de.ibm.com>
	<20080918112713.75872c95@bull.net>
Subject: Re: [PATCH HACK] powerpc: quick hack to get a functional eHEA with
	hardirq preemption, eHCA is close
To: Sebastien Dugue <sebastien.dugue@bull.net>
Message-ID: <OFD7842B7A.ADC47EED-ONC12574C8.003A2CB3-C12574C8.003AC948@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Thu, 18 Sep 2008 12:42:05 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Thomas Q Klein <TKLEIN@de.ibm.com>, tinytim@us.ibm.com,
	Linux-rt <linux-rt-users@vger.kernel.org>,
	Jan-Bernd Themann <THEMANN@de.ibm.com>, netdev@vger.kernel.org,
	jean-pierre.dion@bull.net, linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>,
	Benjamin Herrenschmidt <bherren@au1.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, gilles.carry@ext.bull.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Sebastien Dugue <sebastien.dugue@bull.net> wrote on 18.09.2008 11:27:13:

>
>   It would be really interresting to know if the eHCA exhibits the same
> problem under -rt as it's the only other user of the ibmebus.
> Unfortunately I don't have the hardware to test.
>

eHCA is very close from the interrupt generation and handling perspective,
so yes, could be an issue there as well.


Gruss / Regards
Christoph Raisch
