Return-Path: <jens@de.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4DA9FDDE04
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Jan 2007 08:10:48 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l0KLAhQI100856
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jan 2007 21:10:43 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l0KLAhv3606364
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jan 2007 21:10:43 GMT
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0KLAhIZ031377
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jan 2007 21:10:43 GMT
From: Jens Osterkamp <jens@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 0/4] spidernet: add support for Celleb
Date: Sat, 20 Jan 2007 22:10:36 +0100
References: <200701171000.l0HA0jnD021501@toshiba.co.jp>
	<1169081253.4965.35.camel@localhost.localdomain>
In-Reply-To: <1169081253.4965.35.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701202210.36953.jens@de.ibm.com>
Cc: netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > This is a revised version of the patch set for spider_net driver
> > that works on Toshiba Cell Refererence Set (aka Celleb).
> >
> > This patch set is based on netdev-2.6.git#upstream.
>
> Jens, can you give that a go on our blades see if it doesn't break
> anything ? We are all at LCA here so it's a bit hard to test !

Nope, doesn't work for us...

I have a patch based on Ishizaki's previous patch which I think will work
on Celleb. Will post it here when I have adapted it to the new version.

Jens
