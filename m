Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CBE912C00AB
 for <linuxppc-dev@ozlabs.org>; Sat,  1 Feb 2014 00:32:35 +1100 (EST)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] powerpc: Add cpu family documentation
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1391049480-29346-1-git-send-email-mpe@ellerman.id.au>
Date: Fri, 31 Jan 2014 07:32:18 -0600
Message-Id: <669D726F-25DF-4703-AD30-CAE7CA142970@kernel.crashing.org>
References: <1391049480-29346-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 29, 2014, at 8:38 PM, Michael Ellerman <mpe@ellerman.id.au> =
wrote:

> This patch adds some documentation on the different cpu families
> supported by arch/powerpc.
>=20
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
> Documentation/powerpc/cpu_families.txt | 76 =
++++++++++++++++++++++++++++++++++
> 1 file changed, 76 insertions(+)
> create mode 100644 Documentation/powerpc/cpu_families.txt
>=20
> diff --git a/Documentation/powerpc/cpu_families.txt =
b/Documentation/powerpc/cpu_families.txt
> new file mode 100644
> index 0000000..df72657
> --- /dev/null
> +++ b/Documentation/powerpc/cpu_families.txt
> @@ -0,0 +1,76 @@
> +CPU Families
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This doco tries to summarise some of the different cpu families that =
exist and
> +are supported by arch/powerpc.
> +
> +Book3S (aka sPAPR)
> +------------------
> +
> + - Hash MMU
> + - Mix of 32 & 64 bit
> +
> +  Old
> + POWER --- 601 --- 603
> +   |            |   |
> +   |            |   *----- 740
> +   |            |   |
> +   |            |   *----- 750 (G3) --- 750CX --- 750CL --- 750FX
> +   |            |           |
> +   |            |           |
> +   |           604          *--- 7400 --- 7410 --- 7450 --- 7455 --- =
7447 --- 7448
> +   |            |
> +   |            |
> +   |            *---- [620] --- POWER3/630 --- POWER3+ --- POWER4 --- =
POWER4+ --- POWER5 --- POWER5+ --- POWER5++ --- POWER6 --- POWER7 --- =
POWER7+ --- POWER8
> +   |                 (64bit)                                          =
         |    .
> +   |                                                                  =
         |    .
> +   |                                                                  =
         |    *--- Cell
> +   |                                                                  =
         |
> +   |                                                                  =
         *--- 970 --- 970FX --- 970MP
> +   |
> +   *--- RS64 (threads)
> +
> +
> +  PA6T (64bit) ...
> +
> +
> +IBM BookE
> +---------
> +
> + - Software loaded TLB.
> + - All 32 bit
> +
> +  401 --- 403 --- 405 --- 440 --- 450 --- 460 --- 476
> +                                   |
> +                                   *--- BG/P
> +
> +
> +Motorola/Freescale 8xx
> +----------------------
> +
> + - Software loaded with hardware assist.
> + - All 32 bit
> +
> +  8xx --- 850
> +
> +
> +Freescale BookE
> +---------------
> +
> + - Software loaded TLB.
> + - e6500 adds HW loaded indirect TLB entries.
> + - Mix of 32 & 64 bit
> +
> +  e200 --- e500 --- e500v2 --- e500mc --- e5500 --- e6500
> +                                         (Book3E)  (HW TLB)
> +                                         (64bit)
> +

e200 is its own core family that doesn=92t have any relation to e500 =
line other than being book-e

might want to add multithreaded to e6500.

> +IBM A2 core
> +-----------
> +
> + - Book3E, software loaded TLB + HW loaded indirect TLB entries.
> + - 64 bit
> +
> +  A2 core --- BG/Q
> +     |
> +     *------- WSP
> --=20
> 1.8.3.2
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
