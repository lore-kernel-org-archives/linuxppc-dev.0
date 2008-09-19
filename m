Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 60DE7DDDE1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Sep 2008 22:10:41 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m8JCD6gm013327
	for <linuxppc-embedded@ozlabs.org>; Fri, 19 Sep 2008 08:13:06 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8JCAMdA254458
	for <linuxppc-embedded@ozlabs.org>; Fri, 19 Sep 2008 08:10:22 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m8JCALPv014966
	for <linuxppc-embedded@ozlabs.org>; Fri, 19 Sep 2008 08:10:21 -0400
Date: Fri, 19 Sep 2008 08:10:19 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: ______ <nagne_hsi@naver.com>
Subject: Re: Is there any linux version to support clock and power
	management(CPM) of PPC405
Message-ID: <20080919081019.1d133641@zod.rchland.ibm.com>
In-Reply-To: <004801c91a29$444f0360$cced0a20$@com>
References: <004801c91a29$444f0360$cced0a20$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 19 Sep 2008 16:28:09 +0900
______ <nagne_hsi@naver.com> wrote:

> I am searching the linux version to support clock and power management(CP=
M)
> of PPC405.
>=20
> Linux kernel use the cpu_idle() function when the cpu don=C2=A1=C2=AFt ha=
ve any task
> to do..
>=20
> And, the implementation of cpu_idle() is different between each
> architecture.
>=20
> I cannot find whether latest ppc tree of linux support CPM or not=C2=A1=
=C2=A6.

It does not.

> If the official linux support CPM of PPC405, Do Mvista, Red hat, fedora,
> gentoo support CPM of PPC405?=20

You would have to ask Monta Vista or Wind River if they do.  Red Hat,
Fedora, and Gentoo don't support PPC405 at all.

josh
