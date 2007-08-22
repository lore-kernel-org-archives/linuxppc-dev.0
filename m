Return-Path: <bounces@nabble.com>
Message-ID: <19534218.2117461187753044142.JavaMail.nabble@isper.nabble.com>
From: angelalinyao@163.com
To: Linuxppc-embedded@ozlabs.org
Subject: Why dose system hangs after "Now booting the kernel" ?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 21 Aug 2007 20:24:04 -0700
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
   I am running linux-xilinx-26.git, a MontaVista embedded OS based on kernel 2.6.22, on ML403. I have made the kernel image and downloaded it into the board. But when it ran, the system stopped after printed the message "Now booting the kernel", and no other information was output. I have tried to modify the file "xparameters_ml403.h" because I suspected that the driver for serial port is the problem, but it did not fix the problem. I do not know where the problem is and how to solve it. 
   Any help from you all is appreciated. Thank you!
