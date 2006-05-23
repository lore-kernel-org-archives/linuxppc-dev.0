Return-Path: <eemingliu@hotmail.com>
Received: from hotmail.com (bay110-f2.bay110.hotmail.com [65.54.229.12])
	by ozlabs.org (Postfix) with ESMTP id 0F53667A5B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 May 2006 19:41:32 +1000 (EST)
Message-ID: <BAY110-F242391FBDFC307ED50604B29B0@phx.gbl>
From: "Ming Liu" <eemingliu@hotmail.com>
To: rick.moleres@xilinx.com
Subject: question about linux with Xilinx ML-403
Date: Tue, 23 May 2006 09:41:30 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Rick,
> Yes, we have a driver for the PLB TEMAC (different than the GSRD LL
> TEMAC) for Linux 2.4 (MontaVista Linux 2.4.20) that's shipped in EDK
> 8.1.1, and MontaVista is on the verge of publishing a driver for PLB
> TEMAC for Linux 2.6. (I believe it came across this mailing list a few
> weeks ago)

I have generated the BSP by EDK 8.1.1 for my project in ML403(hardcore 
Temac and PLB Temac included). I noticed that there is a directory called 
Xilinx_gige in the directory of /drivers/net. Is this the driver for 
MontaVista Linux2.4.20? I copied the BSP and overwrote the original one in 
the linux kernel directory (in the kernel directory, there is only a 
directory called Xilinx_enet, no Xilinx_gige. So I just copied 
Xilinx_gige.). However, my problem is in the menuconfig item of Network 
Device Support->1000Mbit ethernet, there is not any option to choose and 
enable the Xilinx on-chip ethernet. Is this a problem of MontaVista Linux 
3.1 Preview Kit, or my problem?  And What shall I do to enable the tri-mode 
Temac in my platform? Thanks for your answer. 

BR
Ming

_________________________________________________________________
√‚∑—œ¬‘ÿ MSN Explorer:   http://explorer.msn.com/lccn/  
