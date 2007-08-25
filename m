Return-Path: <bounces@nabble.com>
Message-ID: <28198861.2449821188008132443.JavaMail.nabble@isper.nabble.com>
From: angelalinyao@163.com
To: Linuxppc-embedded@ozlabs.org
Subject: Has anyone run MontaVista linux-xilinx-26.git based on kernel
	2.6.22 successfully?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Aug 2007 19:15:32 -0700
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, all
    Has anyone run MontaVista linux-xilinx-26.git based on kernel 2.6.22 successfully? I am trying to run this embedded OS on ML403, but have met some problems.
    I downloaded a napshot of the git tree including temac patches and configed it. When I downloaded the kernel image into the board and  run it, the system hung after printed "Now booting the kernel" message. I have tried to modify my kernel configuration, however still did not solve the problem. I did not know where the kernel booting stopped and what problem caused its stop. I even did not know whether the kernel stopped at initialization or start_kernel() function.  
    I think maybe it is the kernel itself that has some problems not the patches, or perhaps it is my kernel configuration that caused the problem but I do not know what is the point. Has anyone run this OS successfully and could give me some directions? 
    Any help from you is appreciated. Thank you!
                                                                                                                            linyao
