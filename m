Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (amanaus.varma-el.com [194.186.189.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.varma-el.com", Issuer "varma-el.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2A792B7D2E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 22 May 2010 04:21:28 +1000 (EST)
Message-ID: <4BF6CD25.9040508@varma-el.com>
Date: Fri, 21 May 2010 22:12:53 +0400
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: =?UTF-8?B?Q1RBRyAvIE1vaXPDqXMgRG9tw61uZ3Vleg==?=
	<moises.dominguez@ctag.com>
Subject: Re: MBX drivers ads5121-rev4-v20090603
References: <B597D6E3752845929B21C3369FB41730@ctag>
In-Reply-To: <B597D6E3752845929B21C3369FB41730@ctag>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Moisés,

CTAG / Moisés Domínguez wrote:
> Hi all,
> 
> I am trying to use MBX 3D engine driver of my ads5121. AFAIK, drivers were
> built against same kernel as mine
i.e. 2.6.24.6 from LTIB? Kernel from Freescale's LTIB != vanilla 2.6.24.6
(number of patches vs vanilla kernel is more than 100)

> but I get problems for testing the demos and for loading the service:
> 
I run demos on ADS without problems, except OGLESRenderToTexture (confirmed bug
in ALT's GL driver).

--
Regards
Andrey

> /[root@freescale /]# etc/init.d/rc.pvr start/
> 
> /[   29.526994] dbgdrv: module license 'unspecified' taints kernel./ /[
> 29.721065] _IORemapWrapper: mapping 1048576 bytes uncached from 0x80000000 to
> 0xe5280000/
> 
> /… /
> 
> * *
> 
> I read in previous threads of this list about similar problems:
> 
> - MBX on kernel 2.6.31: 
> ttp://old.nabble.com/MPC5121ADS-PowerVR-MBX-driver-on-2.6.31-kernel--td26613966.html
> 
> 
> - MBX on kernel 2.6.24: 
> http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-February/067967.html
> 
> 
> According those posts, I would need to recompile modules against my kernel,
> but, of course, I do not have the sources.  Reading ltib doc I read:
> 
> /“Proprietary Packages:/
> 
> /mbx_build13_binaries: This package provides proprietary binary kernel
> modules, libraries,/
> 
> /and test code built from the MBX OpenGL ES DDK.”/
> 
> / /
> 
> Have anybody tested MBX demos provided with freescale SDK with ltib v20090603
> without having to recompile provided .ko’s?
> 
> Regards,
> 
> Moises
> 
> 
> 
> /Board ads5121/
> 
> /Ltib version 20090603/
> 
> /Linux kernel version 2.6.24.6/
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________ Linuxppc-dev mailing list 
> Linuxppc-dev@lists.ozlabs.org https://lists.ozlabs.org/listinfo/linuxppc-dev
