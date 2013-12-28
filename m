Return-Path: <gavin.hu.2010@gmail.com>
MIME-Version: 1.0
Date: Sat, 28 Dec 2013 13:41:11 +0800
Message-ID: <CABiPGEfmEFovARBy0rwjbDpBnVeRrmvQrxgnH+32z0RLUX3Nkw@mail.gmail.com>
Subject: [question] Can the execution of the atomtic operation instruction
 pair lwarx/stwcx be interrrupted by local HW interruptions?
From: Gavin Hu <gavin.hu.2010@gmail.com>
To: Linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=047d7b3436d2842f3904ee91a80e
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--047d7b3436d2842f3904ee91a80e
Content-Type: text/plain; charset=ISO-8859-1

Hi

I notice that there is a pair ppc instructions lwarx and stwcx used to
atomtic operation for instance, atomic_inc/atomic_dec.

In some ppc manuals, they more emphasize its mechanism is that lwarx can
reseve the target memory address preventing other CORE from modifying it.

I assume that there is atomtic operation executing on the CORE0 in a
multicore system. In this situation, does the CORE0 disable the local HW
interrupt?
Can the executing process from the beginning of lwarx and end of stwcx be
interrupted by HW interruptions/exceptions?  Anyway, they are two assembly
instructions.

 Thanks a lot!

"1:    lwarx    %0,0,%2        # atomic_inc\n\
    addic    %0,%0,1\n"
"    stwcx.    %0,0,%2 \n\


BR
Gavin. Hu

--047d7b3436d2842f3904ee91a80e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi <br><div><br>I notice that there is a pair ppc instruct=
ions lwarx and stwcx used to atomtic operation for instance, atomic_inc/ato=
mic_dec.<br><br></div><div>In some ppc manuals, they more emphasize its mec=
hanism is that lwarx can reseve the target memory address preventing other =
CORE from modifying it.<br>
<br></div><div>I assume that there is atomtic operation executing on the CO=
RE0 in a multicore system. In this situation, does the CORE0 disable the lo=
cal HW interrupt?<br></div><div>Can the executing process from the beginnin=
g of lwarx and end of stwcx be interrupted by HW interruptions/exceptions?=
=A0 Anyway, they are two assembly instructions.<br>
<br>=A0Thanks a lot!<br></div><div><br>&quot;1:=A0=A0=A0 lwarx=A0=A0=A0 %0,=
0,%2=A0=A0=A0 =A0=A0=A0 # atomic_inc\n\<br>=A0=A0=A0 addic=A0=A0=A0 %0,%0,1=
\n&quot;<br>&quot;=A0=A0=A0 stwcx.=A0=A0=A0 %0,0,%2 \n\<br><br><br></div><d=
iv>BR<br></div><div>Gavin. Hu<br></div></div>

--047d7b3436d2842f3904ee91a80e--
