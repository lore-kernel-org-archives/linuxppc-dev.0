Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C0682DDED8
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 12:45:52 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m382jm5l010288
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 22:45:48 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m382jmEH194306
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 20:45:48 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m382jmIP001716
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 20:45:48 -0600
Date: Mon, 7 Apr 2008 21:44:15 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Add idle wait support for 44x platforms
Message-ID: <20080407214415.371a8edc@zod.rchland.ibm.com>
In-Reply-To: <200804080441.28739.arnd@arndb.de>
References: <7226bef216680748a503.1207262582@thinkpadL>
	<200804080417.37272.arnd@arndb.de>
	<20080407213127.7bb9a769@zod.rchland.ibm.com>
	<200804080441.28739.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 8 Apr 2008 04:41:28 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Tuesday 08 April 2008, Josh Boyer wrote:
> > >=20
> > > Actually, a static assignment to 0 has not caused the symbol to end up
> > > in .data for many gcc versions, it always goes into .bss now unless y=
ou
> > > assign it a value other than 0 or use explicit section attributes.
> >=20
> > IIRC, gcc 3.2 is still supported and it didn't do that. =C2=A0Old toolc=
hains
> > still exist.
>=20
> Ok, I thought it was before 3.2. The oldest version I had around was
> gcc-3.3 and that had the new behaviour.

http://www.gnu.org/software/gcc/gcc-3.3/changes.html

gcc 3.3.1 it seems.  I thought I included that in the original reply,
but it's late and I suck :).

josh
