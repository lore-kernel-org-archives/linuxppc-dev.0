Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5745C67B53
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jun 2006 05:24:59 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5NJOsaJ016845
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 15:24:54 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k5NJOs8c287304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 15:24:54 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k5NJOr5Q002198
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 15:24:54 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: "merge" branch reset in powerpc.git tree
Date: Fri, 23 Jun 2006 21:24:52 +0200
References: <17563.54330.600099.894958@cargo.ozlabs.ibm.com>
	<17564.6980.694265.974713@hound.rchland.ibm.com>
	<1151089824.22158.2.camel@weaponx.rchland.ibm.com>
In-Reply-To: <1151089824.22158.2.camel@weaponx.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606232124.52879.arnd.bergmann@de.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 23 June 2006 21:10, Josh Boyer wrote:
> git reset --hard 5fa21d821f6972e70942f2c555ec29dde962bdb2
>=20
> That will reset the branch to the commit ID. =A0NOTE: =A0If you have local
> changes on top, they will be wiped out.
>=20
> There might be a way to do it without losing local changes, but I'm a
> git idiot myself still.
>=20
My understanding is that you are not supposed to have local changes
on the branch you are pulling into, but have another branch for
merging the remote tree with your own changes.

Then again, I'm pretty clueless about git as well.

	Arnd <><
