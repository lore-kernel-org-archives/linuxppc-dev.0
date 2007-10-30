Return-Path: <RAISCH@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 92C53DE15C
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 19:39:58 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id l9U8dqRm110246
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 08:39:52 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l9U8dqjh1089638
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 09:39:52 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l9U8dpaw003877
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 09:39:52 +0100
In-Reply-To: <1193610737.9637.1.camel@concordia>
References: <200710261437.29117.ossthema@de.ibm.com>
	<1193610737.9637.1.camel@concordia>
Subject: Re: [PATCH] ehea: add kexec support
To: michael@ellerman.id.au
Message-ID: <OF79E7ACE7.5D0488CE-ONC1257384.002E58C0-C1257384.002F8561@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Tue, 30 Oct 2007 09:39:49 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Thomas Q Klein <TKLEIN@de.ibm.com>, ossthema@linux.vnet.ibm.com,
	Jeff Garzik <jeff@garzik.org>, Jan-Bernd Themann <THEMANN@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <MEDER@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Michael Ellerman <michael@ellerman.id.au> wrote on 28.10.2007 23:32:17:
>
>
> How do you plan to support kdump?
>

When kexec is fully supported kdump should work out of the box
as for any other ethernet card (if you load the right eth driver).
There's nothing specific to kdump you have to handle in
ethernet device drivers.
Hope I didn't miss anything here...

Gruss / Regards
Christoph R
