Return-Path: <FENKES@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 38B9ADDE3A
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 18:43:59 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id l8Q8hs2T112212
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 08:43:54 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l8Q8hsCP2039956
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 10:43:54 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l8Q8hr3K020369
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 10:43:53 +0200
In-Reply-To: <200709251642.41480.arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
MIME-Version: 1.0
Subject: Re: [PATCH 4/5] ibmebus: Move to of_device and of_platform_driver,
	match eHCA and eHEA drivers
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OF1983365C.5CA77642-ONC1257362.002F6D8C-C1257362.002FF658@de.ibm.com>
Date: Wed, 26 Sep 2007 10:43:52 +0200
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

Arnd Bergmann <arnd@arndb.de> wrote on 25.09.2007 16:42:40:

> This is missing a description,

The description is "ibmebus: Move to of_device and of_platform_driver, 
match eHCA and eHEA drivers" -- I thought that should be enough since the 
patch is rather straightforward. I can add a more detailed description, 
though. Revised patch will follow.

> but the patch looks good.

Thanks =)

Joachim
