Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 07FD9DDEDE
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 02:16:06 +1000 (EST)
Message-Id: <1872DAC5-C05B-4857-82A0-84F8FA0117FB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080610140233.GA4061@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: Please pull from 'powerpc-next' branch
Date: Tue, 10 Jun 2008 11:16:02 -0500
References: <Pine.LNX.4.64.0806042232040.23796@blarg.am.freescale.net>
	<20080610140233.GA4061@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 10, 2008, at 9:02 AM, Anton Vorontsov wrote:

> On Wed, Jun 04, 2008 at 10:32:38PM -0500, Kumar Gala wrote:
>> Please pull from 'powerpc-next' branch of
>>
>> 	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git  
>> powerpc-next
>
> Kumar, could you provide some status for these patches?
>
> * rdk/83xx/qe queue
>
> [PATCH 1/7] [POWERPC] sysdev: implement FSL GTM support
> http://patchwork.ozlabs.org/linuxppc/patch?id=18669
>
> [PATCH 2/7] [POWERPC] QE: add support for QE USB clocks routing
> http://patchwork.ozlabs.org/linuxppc/patch?id=18670
>
> [PATCH 3/7] [POWERPC] QE: prepare QE PIO code for GPIO LIB support
> http://patchwork.ozlabs.org/linuxppc/patch?id=18671
>
> [PATCH 4/7] [POWERPC] QE: implement support for the GPIO LIB API
> http://patchwork.ozlabs.org/linuxppc/patch?id=18672
>
> [PATCH 5/7] [POWERPC] 83xx: new board support: MPC8360E-RDK
> http://patchwork.ozlabs.org/linuxppc/patch?id=18673
>
> [PATCH 7/7] [POWERPC] qe_lib: switch to the cpm_muram implementation
> http://patchwork.ozlabs.org/linuxppc/patch?id=18675
>
> * MPC837xRDB ethernet fix
>
> [POWERPC] 83xx: MPC837xRDB's VSC7385 ethernet switch isn't on the  
> MDIO bus
> http://patchwork.ozlabs.org/linuxppc/patch?id=17389
>
> Thanks,

Applied all of these to the various trees.  (powerpc-next for all but  
the last one).  See me email about making sure RDK builds and boots as  
port of the mpc83xx_defconfig.

- k
