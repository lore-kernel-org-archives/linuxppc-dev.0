Return-Path: <pradeepsampath@yahoo.com>
Received: from web83204.mail.mud.yahoo.com (web83204.mail.mud.yahoo.com
	[216.252.101.48]) by ozlabs.org (Postfix) with SMTP id 2802867B6D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Sep 2006 06:31:30 +1000 (EST)
Message-ID: <20060928202450.82132.qmail@web83204.mail.mud.yahoo.com>
Date: Thu, 28 Sep 2006 13:24:50 -0700 (PDT)
From: Pradeep Sampath <pradeepsampath@yahoo.com>
Subject: Linux BSP on linux kernel 2.6
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2138280749-1159475090=:82027"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-2138280749-1159475090=:82027
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi All,
   
  I am new to hardware design and in general embedded development. I am trying to run linux kernel 2.6 on a Xilinx ML403 dev board. I followed the steps indicated by Ameet Patil - http://www.linux.get2knowmore.com/2006/06/30/quick-guide-linux-26-on-xilinx-virtex-ii-pro-boards-part-i/. When I bootup the dev board from compact flash nothing shows up on the serial terminal. But i see the flash download complete on the LCD display.
   
  here are a few steps i performed.
  1. Built the Linux BSP by downloading the ML403 EDK Embededded PowerPC Reference Design and setting the OS and Library Settings to linux_mvl31 using EDK 8.1 SP2.
   
  2. I downloaded the kernel 2.6.17.1 from kernel.org and comipled the image using the cross compiler. While building the .config i set the option for linux to boot from "console=ttyS0,9600 root=/dev/sda2" (since I have the linux partition on /dev/sda2). Thats probably the only difference from Ameet's page which is set to xsa2.)
   
  3. using the download.bit i generated above, and the newly build linux image, I genarated the system.ace file using genace.tcl tool.
   
  4. Copied the system.ace file to CF and powered on the dev board.
   
  But I don't see anything on the serial terminal and i am stuck. Could anybody suggest what i could be missing. Any help will be greatly appreciated!
   
  Regards,
  Pradeep
   
   
   
   
   
   

--0-2138280749-1159475090=:82027
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi All,</div>  <div>&nbsp;</div>  <div>I am new to hardware design and in general embedded development. I&nbsp;am trying to run linux kernel 2.6 on a Xilinx ML403 dev board. I followed the steps indicated by Ameet Patil - <A href="http://www.linux.get2knowmore.com/2006/06/30/quick-guide-linux-26-on-xilinx-virtex-ii-pro-boards-part-i/">http://www.linux.get2knowmore.com/2006/06/30/quick-guide-linux-26-on-xilinx-virtex-ii-pro-boards-part-i/</A>. When I bootup&nbsp;the dev board from&nbsp;compact flash&nbsp;nothing shows up on the&nbsp;serial terminal. But i see the flash download complete on the LCD display.</div>  <div>&nbsp;</div>  <div>here are a few steps i performed.</div>  <div>1. Built the Linux BSP by downloading the ML403 EDK Embededded PowerPC Reference Design and setting the OS and Library Settings to linux_mvl31 using EDK 8.1 SP2.</div>  <div>&nbsp;</div>  <div>2. I downloaded the kernel 2.6.17.1 from kernel.org and comipled the image using the cross compiler.
 While building the .config i set the option for linux to&nbsp;boot from&nbsp;"console=ttyS0,9600 root=/dev/sda2" (since I have the linux partition&nbsp;on /dev/sda2). Thats probably the only difference from Ameet's page which is set&nbsp;to xsa2.)</div>  <div>&nbsp;</div>  <div>3. using the download.bit i generated above, and the newly build linux image, I genarated&nbsp;the system.ace file using genace.tcl tool.</div>  <div>&nbsp;</div>  <div>4. Copied the system.ace file to CF and powered on the dev board.</div>  <div>&nbsp;</div>  <div>But I don't see anything on the serial terminal and i am stuck. Could anybody suggest what i could be missing. Any help will be greatly appreciated!</div>  <div>&nbsp;</div>  <div>Regards,</div>  <div>Pradeep</div>  <div>&nbsp;</div>  <div>&nbsp;</div>  <div>&nbsp;</div>  <div>&nbsp;</div>  <div>&nbsp;</div>  <div>&nbsp;</div>
--0-2138280749-1159475090=:82027--
