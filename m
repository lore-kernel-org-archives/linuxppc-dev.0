Return-Path: <jacmet@gmail.com>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.178])
	by ozlabs.org (Postfix) with ESMTP id 4FC1DDDE24
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 16:46:12 +1000 (EST)
Received: by ik-out-1112.google.com with SMTP id c21so1799627ika.1
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2008 23:46:10 -0700 (PDT)
To: John Linn <John.Linn@xilinx.com>
Subject: Re: [PATCH] [RFC] powerpc: Xilinx: adding virtex5 powerpc 440 support
References: <20080623162856.D5FA41CA806C@mail66-dub.bigfish.com>
	<20080623150846.40d65f08@zod.rchland.ibm.com>
	<20080623213038.490C110B806B@mail11-dub.bigfish.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Tue, 24 Jun 2008 08:46:05 +0200
In-Reply-To: <20080623213038.490C110B806B@mail11-dub.bigfish.com> (John Linn's
	message of "Mon\, 23 Jun 2008 15\:30\:35 -0600")
Message-ID: <87d4m79vpu.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "John" == John Linn <John.Linn@xilinx.com> writes:

Hi John,

 >>> +config PPC_FPU
 >>> +	depends on XILINX_VIRTEX_5_FXT
 >>> +	bool "Enable Xilinx Soft FPU"
 >>> +	help
 >>> +	  This option enables the Xilinx Soft FPU attached to the APU
 >>> +	  interface of the PPC440 (requires DP_FULL FPU pcore).
 >> 
 >> There is already a PPC_FPU option in platforms/Kconfig.cputype

Is the Xilinx soft FPU compatible with the normal powerpc FPU?

-- 
Bye, Peter Korsgaard
