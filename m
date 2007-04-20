Return-Path: <hunter.cobbs@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by ozlabs.org (Postfix) with ESMTP id 234EADDE3B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Apr 2007 12:15:29 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id b21so884559ana
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Apr 2007 19:15:28 -0700 (PDT)
Message-ID: <ad84a70a0704191915p3b17af9wef3c7b6af2f96383@mail.gmail.com>
Date: Thu, 19 Apr 2007 21:15:27 -0500
From: "Hunter Cobbs" <hunter.cobbs@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Guide to porting to an MPC82xx or any PPC for that mater
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_77605_23989140.1177035327311"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_77605_23989140.1177035327311
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Is there anywhere I can turn to help me figure out how to at least get a
serial console running on SCC1 from an MPC8247 in Linux 2.6.(14+) ?


Our current version of uboot puts data out on SCC1 quite well and I can
compile and load a 2.6 kernel.  I run into a problem following boot where no
more data comes over the SCC1.

I have used the jtag port to get a register dump during uboot and one as
soon as it's obvious no data is coming from scc1.  None of the registers
pertaining to the serial configuration are different.

I've been digging around in the kernel and the default SCC1 hookup bitmasks
are exactly the same as our working 2.4 kernel.  I just can't seem to make
linux use SCC1 as a serial console.  I even tried consoel=ttyCPM[0..5] to
attempt to force it out a SCC1.

Since this is my first attempt at porting (or creating a BSP for that
matter), I'm sure I'm overlooking something exceedingly easy.  I just need
something other than raw kernel code to help me out.

-- 
Hunter Cobbs

------=_Part_77605_23989140.1177035327311
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Is there anywhere I can turn to help me figure out how to at least get
a serial console running on SCC1 from an MPC8247 in Linux 2.6.(14+) ?<br><br><br>Our current version of uboot puts data out on SCC1 quite well and I can compile and load a 2.6 kernel.&nbsp; I run into a problem following boot where no more data comes over the SCC1.
<br><br>I have used the jtag port to get a register dump during uboot and one as soon as it&#39;s obvious no data is coming from scc1.&nbsp; None of the registers pertaining to the serial configuration are different.<br><br>I&#39;ve been digging around in the kernel and the default SCC1 hookup bitmasks are exactly the same as our working 
2.4 kernel.&nbsp; I just can&#39;t seem to make linux use SCC1 as a serial console.&nbsp; I even tried consoel=ttyCPM[0..5] to attempt to force it out a SCC1.&nbsp; <br><br>Since this is my first attempt at porting (or creating a BSP for that matter), I&#39;m sure I&#39;m overlooking something exceedingly easy.&nbsp; I just need something other than raw kernel code to help me out.
<br clear="all"><br>-- <br>Hunter Cobbs

------=_Part_77605_23989140.1177035327311--
