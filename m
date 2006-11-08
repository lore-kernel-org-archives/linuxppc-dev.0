Return-Path: <pradeepsampath@yahoo.com>
Received: from web83215.mail.mud.yahoo.com (web83215.mail.mud.yahoo.com
	[216.252.101.71]) by ozlabs.org (Postfix) with SMTP id 2351267D14
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Nov 2006 19:44:16 +1100 (EST)
Message-ID: <20061108084414.7448.qmail@web83215.mail.mud.yahoo.com>
Date: Wed, 8 Nov 2006 00:44:14 -0800 (PST)
From: Pradeep Sampath <pradeepsampath@yahoo.com>
Subject: Re: minor progress with plb_temac v3.00a, EDK 8.2, & 2.6.18.1
To: robert corley <rdcorle@yahoo.com>, linuxppc-embedded@ozlabs.org
In-Reply-To: <20061107183700.62673.qmail@web56307.mail.re3.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1253998032-1162975454=:6913"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1253998032-1162975454=:6913
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Robert,
 
 I now created the BSP from scratch and its lot better than attempting to upgrade an existing design. I patched "xilinx_temac" and "xilinx_common" , but i am running into another error. I guess i have to start patching the code all over again.
 Please take a look if you can comment on it...
 psampath@psampath-test:~/kernel2.6.18$ make ARCH=ppc zImage.initrd
   CHK     include/linux/version.h
   CHK     include/linux/utsrelease.h
   CC      arch/ppc/kernel/asm-offsets.s
 In file included from include/asm/ibm4xx.h:54,
                  from include/asm/io.h:28,
                  from include/asm/pgtable.h:14,
                  from include/linux/mm.h:38,
                  from include/linux/mman.h:14,
                  from arch/ppc/kernel/asm-offsets.c:19:
 arch/ppc/platforms/4xx/xilinx_ml403.h:33: error: two or more data types in declaration of `bd_t'
 make[1]: *** [arch/ppc/kernel/asm-offsets.s] Error 1
 make: *** [prepare0] Error 2
 psampath@psampath-test:~/kernel2.6.18$
 
-Pradeep
 
robert corley <rdcorle@yahoo.com> wrote: Pradeep;

I found the process of "uprading" the xapp902 reference design to be troublesome when I removed the GMII loop-back; as
such, I aborted the process and just started from scratch.

I am currently debugging my design and have a functional plb_temac but only at 10Mbps speeds.

-R. Corley




--0-1253998032-1162975454=:6913
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Robert,<br> <br> I now created the BSP from scratch and its lot better than attempting to upgrade an existing design. I patched "xilinx_temac" and "xilinx_common" , but i am running into another error. I guess i have to start patching the code all over again.<br> Please take a look if you can comment on it...<br> psampath@psampath-test:~/kernel2.6.18$ make ARCH=ppc zImage.initrd<br> &nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp; include/linux/version.h<br> &nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp; include/linux/utsrelease.h<br> &nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/ppc/kernel/asm-offsets.s<br> In file included from include/asm/ibm4xx.h:54,<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from include/asm/io.h:28,<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from include/asm/pgtable.h:14,<br>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from include/linux/mm.h:38,<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from include/linux/mman.h:14,<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from arch/ppc/kernel/asm-offsets.c:19:<br> arch/ppc/platforms/4xx/xilinx_ml403.h:33: error: two or more data types in declaration of `bd_t'<br> make[1]: *** [arch/ppc/kernel/asm-offsets.s] Error 1<br> make: *** [prepare0] Error 2<br> psampath@psampath-test:~/kernel2.6.18$<br> <br>-Pradeep<br> <br><b><i>robert corley &lt;rdcorle@yahoo.com&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> <style type="text/css"><!-- DIV {margin:0px;} --></style><div style="font-family: times new roman,new york,times,serif; font-size: 12pt;"><div
 style="font-family: times new roman,new york,times,serif; font-size: 12pt;">Pradeep;<br><br>I found the process of "uprading" the xapp902 reference design to be troublesome when I removed the GMII loop-back; as<br>such, I aborted the process and just started from scratch.<br><br>I am currently debugging my design and have a functional plb_temac but only at 10Mbps speeds.<br><br>-R. Corley<br></div></div></blockquote><br>
--0-1253998032-1162975454=:6913--
