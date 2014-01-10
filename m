Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0149.outbound.protection.outlook.com [207.46.163.149])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D7F812C0082
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2014 13:44:20 +1100 (EST)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [v6,4/4] powerpc/85xx: add sysfs for pw20 state and altivec idle
Date: Fri, 10 Jan 2014 02:44:10 +0000
Message-ID: <4ae9367928e44a028ca28fefb76b37d4@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1387268222-9703-4-git-send-email-dongsheng.wang@freescale.com>
 <20140109235134.GA24262@home.buserror.net>
In-Reply-To: <20140109235134.GA24262@home.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "Bharat.Bhushan@freescale.com" <Bharat.Bhushan@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> /home/scott/fsl/git/linux/upstream/arch/powerpc/kernel/sysfs.c:326:19: er=
ror:
> 'PWRMGTCR0_AV_IDLE_CNT' undeclared (first use in this function)
> /home/scott/fsl/git/linux/upstream/arch/powerpc/kernel/sysfs.c:329:36: er=
ror:
> 'PWRMGTCR0_AV_IDLE_CNT_SHIFT' undeclared (first use in this function)
> make[2]: *** [arch/powerpc/kernel/sysfs.o] Error 1
> make[1]: *** [arch/powerpc/kernel] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [sub-make] Error 2
>=20
> I'll fix when applying with this:
>=20

:), Thanks.=20

-Dongsheng
