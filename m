Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 5C2031007D3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2012 21:04:32 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 11051-06 for <linuxppc-dev@lists.ozlabs.org>;
 Fri,  2 Mar 2012 09:57:50 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] powerpc/srio: Fix the compile errors when building with
 64bit
Date: Fri, 2 Mar 2012 09:57:01 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B6E8B@saturn3.aculab.com>
In-Reply-To: <1330672127-22172-1-git-send-email-Gang.Liu@freescale.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Liu Gang" <Gang.Liu@freescale.com>, <linuxppc-dev@lists.ozlabs.org>,
 <Alexandre.Bounine@idt.com>
Cc: r58472@freescale.com, linux-kernel@vger.kernel.org, r61911@freescale.com,
 Paul Gortmaker <paul.gortmaker@windriver.com>, akpm@linux-foundation.org,
 Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> For the file "arch/powerpc/sysdev/fsl_rmu.c", there will be=20
> some compile errors while using the corenet64_smp_defconfig:

I'm sure that replacing 'u32' with 'unsigned long'
is really the best thing to do here.
It looks to me as though they should be some pointer type.

	David
