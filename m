Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1D5F2DDEDA
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 22:30:52 +1100 (EST)
From: Yuri Tikhonov <yur@emcraft.com>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH 1/1] [PPC] 8xx swap bug-fix
Date: Sat, 2 Feb 2008 14:30:59 +0300
References: <20080201181003.a3daf6ed.kim.phillips@freescale.com>
	<200802021047.32055.yur@emcraft.com> <47A45269.7080403@scram.de>
In-Reply-To: <47A45269.7080403@scram.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802021430.59102.yur@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


 Hi Jochen,

 The board for which this fix was developed is one of these (ivms8). Here are 
some other: rpxlite, TQM860L, rpxcllf, bseip, FADS, and etc...

  Just do grep -r "CONFIG_8xx=y" arch/ppc/configs/ and grep -r "CONFIG_8xx=y" 
arch/powerpc/configs/ :)

 Regards, Yuri

On Saturday 02 February 2008 14:22, you wrote:
...
> >  Here is the patch which makes Linux-2.6 swap routines operate correctly 
on
> > the ppc-8xx-based machines.
> 
> is there any 8xx board left which isn't ported to ARCH=powerpc?
> 
> Thanks,
> Jochen 
> 

-- 
Yuri Tikhonov, Senior Software Engineer
Emcraft Systems, www.emcraft.com
