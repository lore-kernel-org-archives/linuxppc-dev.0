Return-Path: <evilninja@gmx.net>
Received: from mail.g-house.de (ns1.g-housing.de [62.75.136.201])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A023C2BF07
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jan 2005 08:21:09 +1100 (EST)
Message-ID: <39090.195.126.66.126.1105046464.squirrel@housecafe.dyndns.org>
In-Reply-To: <20050106210742.GA8598@pegasos>
References: <200412261435.13562.marc.dietrich@ap.physik.uni-giessen.de>
	<200501041504.57588.marvin24@gmx.de>
	<1104850036.6164.25.camel@weizen.left.earth>
	<200501051233.25622.marvin24@gmx.de> <20050105154753.GA26760@pegasos>
	<41DC1F7E.5030003@gmx.net> <20050105173908.GC29131@pegasos>
	<41DD60A3.3020203@gmx.net> <20050106162711.GA32598@pegasos>
	<21643.195.126.66.126.1105043230.squirrel@housecafe.dyndns.org>
	<20050106210742.GA8598@pegasos>
Date: Thu, 6 Jan 2005 22:21:04 +0100 (CET)
From: "Christian" <evilninja@gmx.net>
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: Re: [FYI] linux 2.6 still not working with PReP (ppc32)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, January 6, 2005 22:07, Sven Luther said:
>>
>> no disks attached, but i will do some more tests on this tonight...
>
> Ah, no wonder you don't see a disk then ...

;-)

> I wonder if d-i is upto installing a NFS-root system, i don't think so.

yes, i can see that. nfsroot is my only way to go here. (will probably get
a proper scsi-cable soon)

> See :
>   http://svn.debian.org/wsvn/kernel/trunk/kernel/source/kernel-source-2.6.8-2.6.8/debian/patches/powerpc-prep-powerstack-irq.dpatch?op=file&rev=0&sc=0

ah, ok. will try.

thanks,
Christian.
-- 
make bzImage, not war
