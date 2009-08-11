Return-Path: <msridhar87@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 66A3AB7099
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 Aug 2009 00:10:01 +1000 (EST)
MIME-Version: 1.0
Date: Tue, 11 Aug 2009 19:39:57 +0530
Message-ID: <70ca52c20908110709m41b1535ep4c8ed900163f3b18@mail.gmail.com>
Subject: cross compiling wind river linux for ppc architecture
From: Sridhar Mahadevan <msridhar87@gmail.com>
To: Linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=0016367f96e0e82f980470de41b8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016367f96e0e82f980470de41b8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,
Am trying to compile my WRL 2.6.21 kernel for PPC architecture.
The processor am using is AMCC powerpc 440EP .
I just built the file system by running the configure command with
--enable-rootfs=glibc-small and --enable-cpu-ppc-440 and i got a cross
compiler.
I took the linux kernel image and updated the PATH variable to the path of
my cross compiler.I did a make with ARCH=powerpc and CROSS_COMPILER=/my
cross compiler,except gcc/.

When I try to do this I get the following error.
 arch/powerpc/mm/44x_mmu.c: In function 'mmu_mapin_ram':
arch/powerpc/mm/44x_mmu.c:106: error: 'PPC_PIN_SIZE' undeclared (first use
in this function)
arch/powerpc/mm/44x_mmu.c:106: error: (Each undeclared identifier is
reported only once
arch/powerpc/mm/44x_mmu.c:106: error: for each function it appears in.)
arch/powerpc/mm/44x_mmu.c:106: error: 'PPC44x_PIN_SHIFT' undeclared (first
use in this function)
arch/powerpc/mm/44x_mmu.c:109: error: 'PPC44x_LOW_SLOT' undeclared (first
use in this function)
make[1]: *** [arch/powerpc/mm/44x_mmu.o] Error 1
make: *** [arch/powerpc/mm] Error 2
It ll be very helpful for me if I could get a solution for this.

Regards
Sridhar M

--0016367f96e0e82f980470de41b8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div>
<div>Am trying to compile my WRL 2.6.21 kernel for PPC architecture.</div>
<div>The processor am using is AMCC powerpc 440EP .</div>
<div>I just built the file system by running the configure command with --e=
nable-rootfs=3Dglibc-small and --enable-cpu-ppc-440 and i got a cross compi=
ler.</div>
<div>I took the linux kernel image and updated the PATH variable to the pat=
h of my cross compiler.I did a make with ARCH=3Dpowerpc and CROSS_COMPILER=
=3D/my cross compiler,except gcc/.</div>
<div>=A0</div>
<div>When I try to do this I get the following error.</div>
<div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"730463712-11082009">arc=
h/powerpc/mm/44x_mmu.c: In function &#39;mmu_mapin_ram&#39;:<br>arch/powerp=
c/mm/44x_mmu.c:106: error: &#39;PPC_PIN_SIZE&#39; undeclared (first use in =
this function)<br>
arch/powerpc/mm/44x_mmu.c:106: error: (Each undeclared identifier is report=
ed only once<br>arch/powerpc/mm/44x_mmu.c:106: error: for each function it =
appears in.)<br>arch/powerpc/mm/44x_mmu.c:106: error: &#39;PPC44x_PIN_SHIFT=
&#39; undeclared (first use in this function)<br>
arch/powerpc/mm/44x_mmu.c:109: error: &#39;PPC44x_LOW_SLOT&#39; undeclared =
(first use in this function)<br>make[1]: *** [arch/powerpc/mm/44x_mmu.o] Er=
ror 1<br>make: *** [arch/powerpc/mm] Error 2<br></span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"730463712-11082009">It =
ll be very helpful for me if I could get a solution for this.</span></font>=
</div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"730463712-11082009"></s=
pan></font>=A0</div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"730463712-11082009">Reg=
ards</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span class=3D"730463712-11082009">Sri=
dhar M</span></font></div></div>

--0016367f96e0e82f980470de41b8--
