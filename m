Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 961ACDE1BF
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Oct 2008 22:21:27 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m92CLO8G010275
	for <linuxppc-embedded@ozlabs.org>; Thu, 2 Oct 2008 08:21:24 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m92CLOpj263302
	for <linuxppc-embedded@ozlabs.org>; Thu, 2 Oct 2008 08:21:24 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m92CLNpX017717
	for <linuxppc-embedded@ozlabs.org>; Thu, 2 Oct 2008 08:21:23 -0400
Date: Thu, 2 Oct 2008 08:21:22 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: =?UTF-8?B?5YiY5p6X?= <liu_lin02@tsinghua.org.cn>
Subject: Re: Build cross compile tool chain for PPC
Message-ID: <20081002082122.4bb97461@zod.rchland.ibm.com>
In-Reply-To: <422942429.11977@tsinghua.org.cn>
References: <422942429.11977@tsinghua.org.cn>
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

On Thu, 02 Oct 2008 18:13:49 +0800
"=C3=A5=C2=88=C2=98=C3=A6=C2=9E=C2=97" <liu_lin02@tsinghua.org.cn> wrote:

> Hi, All,
>=20
> I am a newby for ppc embedded linux. When trying to build the cross compi=
ling tool
> chain, I got some error message in making glibc (binutils and gcc are suc=
cessfully
> built).
>=20
> Error message is:
>=20
> {quote}
> assert.c: In function =C2=A1=C2=AE__assert_fail=C2=A1=C2=AF:
> assert.c:54: error: =C2=A1=C2=AE__libc_pthread_functions_init=C2=A1=C2=AF=
 undeclared (first use in
> this function)
> assert.c:54: error: (Each undeclared identifier is reported only once
> assert.c:54: error: for each function it appears in.)
> assert.c:54: warning: implicit declaration of function =C2=A1=C2=AEPTHFCT=
_CALL=C2=A1=C2=AF
> assert.c:54: error: =C2=A1=C2=AEptr_pthread_setcancelstate=C2=A1=C2=AF un=
declared (first use in this
> function)
> assert.c:54: warning: left-hand operand of comma expression has no effect
> make[2]: ***
> [/root/embedded_linux/ppc/build-tools/build-glibc/ppc-glibc/assert/assert=
.os]
> Error 1
> make[2]: Leaving directory
> `/root/embedded_linux/ppc/build-tools/build-glibc/glibc-2.7/assert'
> make[1]: *** [assert/subdir_lib] Error 2
> make[1]: Leaving directory
> `/root/embedded_linux/ppc/build-tools/build-glibc/glibc-2.7'
> make: *** [all] Error 2
>=20
> {quote}
>=20
> My environments are:
>=20
> kernel: 2.26.     25
> gcc & powerpc-linux-gcc: 4.3.2
> binutils:2.18
> glibc:2.7, configured with  linuxthreads enabled and nptl disabled.

glibc 2.7 does not support linuxthreads.  It is nptl only.  And you
should really be using nptl anyway.

josh
