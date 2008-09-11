Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CB63DDDF67
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 21:42:50 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m8BBgZLT024593
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 07:42:35 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8BBgZsu205840
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 07:42:35 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m8BBgYbJ018045
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 07:42:35 -0400
Date: Thu, 11 Sep 2008 07:42:23 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: =?UTF-8?B?Um9nw6lyaW8=?= Brito <rbrito@ime.usp.br>
Subject: Re: Getting Debian to release the PowerPC port
Message-ID: <20080911074223.365e763a@zod.rchland.ibm.com>
In-Reply-To: <20080911035514.GE8077@ime.usp.br>
References: <20080911035514.GE8077@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, 497605@bugs.debian.org,
	Paul Mackerras <paulus@samba.org>,
	debian-powerpc@lists.debian.org, debian-release@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 11 Sep 2008 00:55:14 -0300
Rog=C3=A9rio Brito <rbrito@ime.usp.br> wrote:

> Dear Paul,
>=20
> I would like to ask you a few things:
>=20
> * which is the official dtc git repository?
>   I ask it here because dtc.ozlabs.org doesn't seem to work, but this is
>   what is linked to from the page <http://ozlabs.org/> and the
>   device-tree-compiler package on Debian has an outdated page (it
>   seems). I already filed a bugreport to that package
>   (http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D497605).

git://www.jld.com/software/dtc.git

Though the kernel embeds the dtc source in it now, and a stand-alone
dtc is not required for kernel builds.

> * where can I find the people responsible for glibc and gcc/g++ so that
>   I can fill in the empty fields at
>   <http://wiki.debian.org/powerpcLennyReleaseRecertification>, so that
>   powerpc does not become "at risk" of not being released? Is the
>   powerpc port cared by some team in special or is it just a "unified"
>   upstream?

PowerPC is supported in the upstream GNU glibc and gcc projects.  There
is no separate repository for those.  The PowerPC maintainers for those
projects can be found on the website for glibc (it's Steven Munroe), or
in the MAINTAINERS file in gcc.  PowerPC is called 'rs6000' in gcc for
historical reasons.

josh
