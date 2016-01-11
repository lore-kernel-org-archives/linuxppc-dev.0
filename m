Return-Path: <sjmunroe@us.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E1631A0D35
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 08:43:39 +1100 (AEDT)
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 88F271402A0
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 08:43:38 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sjmunroe@us.ibm.com>;
 Mon, 11 Jan 2016 14:43:36 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id B9B2A3E4004E
 for <linuxppc-dev@ozlabs.org>; Mon, 11 Jan 2016 14:43:33 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0BLhXZI27787406
 for <linuxppc-dev@ozlabs.org>; Mon, 11 Jan 2016 14:43:33 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0BLhXAp026241
 for <linuxppc-dev@ozlabs.org>; Mon, 11 Jan 2016 14:43:33 -0700
Received: from d50lp01.ny.us.ibm.com (d50lp01.pok.ibm.com [146.89.104.207])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u0BLhWAt026201
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@ozlabs.org>; Mon, 11 Jan 2016 14:43:33 -0700
Message-Id: <201601112143.u0BLhWAt026201@d03av04.boulder.ibm.com>
Received: from /spool/local
 by d50lp01.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sjmunroe@us.ibm.com>;
 Mon, 11 Jan 2016 16:33:28 -0500
Received: from /spool/local
 by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
 for <linuxppc-dev@ozlabs.org> from <sjmunroe@us.ibm.com>;
 Mon, 11 Jan 2016 21:33:26 -0000
In-Reply-To: <1452481144-26173-1-git-send-email-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Add HWCAP bits for Power9
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: adhemerval.zanella@linaro.org, bergner@vnet.ibm.com,
 cseo@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org, tuliom@linux.vnet.ibm.com
From: "Steve Munroe" <sjmunroe@us.ibm.com>
Date: Mon, 11 Jan 2016 15:33:15 -0600
References: <1452481144-26173-1-git-send-email-mpe@ellerman.id.au>
Content-type: multipart/alternative;
 Boundary="0__=8FBBF5A4DFE5B2578f9e8a93df938690918c8FBBF5A4DFE5B257"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--0__=8FBBF5A4DFE5B2578f9e8a93df938690918c8FBBF5A4DFE5B257
Content-Transfer-Encoding: quoted-printable
Content-type: text/plain; charset=US-ASCII

Michael Ellerman <mpe@ellerman.id.au> wrote on 01/10/2016 08:59:04 PM:

> From: Michael Ellerman <mpe@ellerman.id.au>
> To: <linuxppc-dev@ozlabs.org>
> Cc: tuliom@linux.vnet.ibm.com, adhemerval.zanella@linaro.org,
> cseo@linux.vnet.ibm.com, bergner@vnet.ibm.com, Steve Munroe/
> Rochester/IBM@IBMUS
> Date: 01/10/2016 08:59 PM
> Subject: [PATCH] powerpc: Add HWCAP bits for Power9
>
> In order to support Power9 we need two new HWCAP bits. We are merging
> these ahead of the cputable entry so that glibc can start referring to
> them.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/uapi/asm/cputable.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/powerpc/include/uapi/asm/cputable.h b/arch/
> powerpc/include/uapi/asm/cputable.h
> index 43686043e297..8dde19962a5b 100644
> --- a/arch/powerpc/include/uapi/asm/cputable.h
> +++ b/arch/powerpc/include/uapi/asm/cputable.h
> @@ -43,5 +43,7 @@
>  #define PPC=5FFEATURE2=5FTAR      0x04000000
>  #define PPC=5FFEATURE2=5FVEC=5FCRYPTO      0x02000000
>  #define PPC=5FFEATURE2=5FHTM=5FNOSC      0x01000000
> +#define PPC=5FFEATURE2=5FARCH=5F3=5F00      0x00800000 /* ISA 3.00 */
> +#define PPC=5FFEATURE2=5FHAS=5FIEEE128   0x00400000 /* VSX IEEE Binary
> Float 128-bit */
>
>  #endif /* =5FUAPI=5F=5FASM=5FPOWERPC=5FCPUTABLE=5FH */
> --
> 2.5.0
>
We need this in mainline kernel ASAP or the GLIBC maintainers are going to
force us to revert our patch. Missing GLIBC2.23.

Steven J. Munroe
Linux on Power Toolchain Architect
IBM Corporation, Linux Technology Center




--0__=8FBBF5A4DFE5B2578f9e8a93df938690918c8FBBF5A4DFE5B257
Content-Transfer-Encoding: quoted-printable
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body><p><tt>Michael Ellerman &lt;mpe@ellerman.id.au&gt; wrote on 01/=
10/2016 08:59:04 PM:<br><br>&gt; From: Michael Ellerman &lt;mpe@ellerman.id=
.au&gt;</tt><br><tt>&gt; To: &lt;linuxppc-dev@ozlabs.org&gt;</tt><br><tt>&g=
t; Cc: tuliom@linux.vnet.ibm.com, adhemerval.zanella@linaro.org, <br>&gt; c=
seo@linux.vnet.ibm.com, bergner@vnet.ibm.com, Steve Munroe/<br>&gt; Rochest=
er/IBM@IBMUS</tt><br><tt>&gt; Date: 01/10/2016 08:59 PM</tt><br><tt>&gt; Su=
bject: [PATCH] powerpc: Add HWCAP bits for Power9</tt><br><tt>&gt; <br>&gt;=
 In order to support Power9 we need two new HWCAP bits. We are merging<br>&=
gt; these ahead of the cputable entry so that glibc can start referring to<=
br>&gt; them.<br>&gt; <br>&gt; Signed-off-by: Michael Ellerman &lt;mpe@elle=
rman.id.au&gt;<br>&gt; ---<br>&gt; &nbsp;arch/powerpc/include/uapi/asm/cput=
able.h | 2 ++<br>&gt; &nbsp;1 file changed, 2 insertions(+)<br>&gt; <br>&gt=
; diff --git a/arch/powerpc/include/uapi/asm/cputable.h b/arch/<br>&gt; pow=
erpc/include/uapi/asm/cputable.h<br>&gt; index 43686043e297..8dde19962a5b 1=
00644<br>&gt; --- a/arch/powerpc/include/uapi/asm/cputable.h<br>&gt; +++ b/=
arch/powerpc/include/uapi/asm/cputable.h<br>&gt; @@ -43,5 +43,7 @@<br>&gt; =
&nbsp;#define PPC=5FFEATURE2=5FTAR &nbsp; &nbsp; &nbsp;0x04000000<br>&gt; &=
nbsp;#define PPC=5FFEATURE2=5FVEC=5FCRYPTO &nbsp; &nbsp; &nbsp;0x02000000<b=
r>&gt; &nbsp;#define PPC=5FFEATURE2=5FHTM=5FNOSC &nbsp; &nbsp; &nbsp;0x0100=
0000<br>&gt; +#define PPC=5FFEATURE2=5FARCH=5F3=5F00 &nbsp; &nbsp; &nbsp;0x=
00800000 /* ISA 3.00 */<br>&gt; +#define PPC=5FFEATURE2=5FHAS=5FIEEE128 &nb=
sp; 0x00400000 /* VSX IEEE Binary <br>&gt; Float 128-bit */<br>&gt; &nbsp;<=
br>&gt; &nbsp;#endif /* =5FUAPI=5F=5FASM=5FPOWERPC=5FCPUTABLE=5FH */<br>&gt=
; -- <br>&gt; 2.5.0<br>&gt; </tt><br><tt>We need this in mainline kernel AS=
AP or the GLIBC maintainers are going to force us to revert our patch. Miss=
ing GLIBC2.23.</tt><br><br>Steven J. Munroe<br>Linux on Power Toolchain Arc=
hitect<br>IBM Corporation, Linux Technology Center<br><br><br><tt><br></tt>=
<BR>
</body></html>

--0__=8FBBF5A4DFE5B2578f9e8a93df938690918c8FBBF5A4DFE5B257--
