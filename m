Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id B43A3DDF1E
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 15:54:32 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KB1U4-0008Fs-42
	for linuxppc-dev@ozlabs.org; Mon, 23 Jun 2008 22:54:28 -0700
Message-ID: <18084260.post@talk.nabble.com>
Date: Mon, 23 Jun 2008 22:54:28 -0700 (PDT)
From: jumpingProgrammer <rabbitzp@163.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Using DMA interrupt on MPC8313
In-Reply-To: <329782.75894.qm@web83515.mail.sp1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <937773.70026.qm@web83508.mail.sp1.yahoo.com>
	<038420D9-89B1-41B4-8941-CF12CD7F4D61@kernel.crashing.org>
	<85644.91618.qm@web83508.mail.sp1.yahoo.com>
	<4D6BC3F2-C43D-4317-B0BE-AF0A551E6CF1@kernel.crashing.org>
	<973175.42029.qm@web83503.mail.sp1.yahoo.com>
	<094E5361-18FC-47D7-BB7C-8A8AF89DBEC1@kernel.crashing.org>
	<470944.9117.qm@web83514.mail.sp1.yahoo.com>
	<2FCBCE91-8B77-4E78-A7F9-D4128980814F@kernel.crashing.org>
	<101441.49932.qm@web83508.mail.sp1.yahoo.com>
	<4856A3CA.4010905@freescale.com>
	<788575.91210.qm@web83508.mail.sp1.yahoo.com>
	<4856B3B4.9020206@freescale.com>
	<329782.75894.qm@web83515.mail.sp1.yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I use this in 8313erdb.dts, but can not find DMA info in
/proc/interrupts.why?

dma@8030 { 
			#address-cells = <1>; 
			#size-cells = <1>; 
			compatible = "fsl,elo-dma"; 
			cell-index = <0>; 
			reg = <8030 2d0>; /* DMA general status register */ 
			ranges = <0 8100 200>; 

			dma-channel@0 { 
				compatible = "fsl,elo-dma-channel"; 
				cell-index = <0>; 
				reg = <0 80>; 
				interrupt-parent = <700>; 
				interrupts = <47 8>; 
			}; 
			dma-channel@1 { 
				compatible = "fsl,elo-dma-channel"; 
				cell-index = <1>; 
				reg = <80 80>; 
				interrupt-parent = <700>; 
				interrupts = <47 8>; 
			}; 
			dma-channel@2 { 
				compatible = "fsl,elo-dma-channel"; 
				cell-index = <2>; 
				reg = <100 80>; 
				interrupt-parent = <700>; 
				interrupts = <47 8>; 
			}; 
			dma-channel@3 { 
				compatible = "fsl,elo-dma-channel"; 
				cell-index = <3>; 
				reg = <180 80>; 
				interrupt-parent = <700>; 
				interrupts = <47 8>; 
			};
		}


_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev



-- 
View this message in context: http://www.nabble.com/Using-DMA-interrupt-on-MPC8313-tp17808164p18084260.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
