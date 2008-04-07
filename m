Return-Path: <luoxu_gun@yahoo.com.cn>
Received: from web15907.mail.cnb.yahoo.com (web15907.mail.cnb.yahoo.com
	[202.165.103.52]) by ozlabs.org (Postfix) with SMTP id 09F73DDDFA
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Apr 2008 11:42:41 +1000 (EST)
Date: Mon, 7 Apr 2008 09:35:17 +0800 (CST)
From: =?gb2312?q?=D0=F1=20=C2=DE?= <luoxu_gun@yahoo.com.cn>
Subject: a question about use dtb to bootting linux kernel on MPC83xx platform
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1530653995-1207532117=:18740"
Message-ID: <959437.18740.qm@web15907.mail.cnb.yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-1530653995-1207532117=:18740
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

    I am Linux software engineer. These days I was debugging a MPC8313 system. In  the debugging process, some source code in the kernel makes me puzzled. So I  have find your email address in the source code. I think you can give me some  advises to solve the problem.
  
        My version is  linux-2.6.23.9 and I use the device tree(dtb) to  booting the kernel. In my bootloader I use the following code to jump to the  kernel.
 (*image)((bd_t *)dtb_entry,  (unsigned int)image, 0, 0, 0); 
  
 The dtb_entry is the address of dtb  file which in the SDRAM, the image is the kernel entry point. I flashed some  LEDs in my board. So I can make sure the program run to the machine_init() which  is defined in the /arch/powerpc/kernel/setup_32.c
In order to trace the problem I  search the source code. I can find that these information is printed by the  start function which is defined in the /arch/powerpc/boot/main.c.  
 Fourth more I have found that the  kernel call the platform_init which is defined in the  /arch/powerpc/boot/cuboot-83xx.c. looking the file head I have known you are the  author for this file.
 Could you told me how the kernel  call the platform_init function and I hope you can show me the booting process  of the MPC83xx linux or you could give me some document about  it.

       
---------------------------------
 —≈ª¢” œ‰£¨ƒ˙µƒ÷’…˙” œ‰£°
--0-1530653995-1207532117=:18740
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

 <div class="MsoNormal"><font face="Arial" size="3"><span style="font-size: 12pt; font-family: Arial;" lang="EN-US">&nbsp;&nbsp; I am Linux software engineer. These days I was debugging a MPC8313 system. In  the debugging process, some source code in the kernel makes me puzzled. So I  have find your email address in the source code. I think you can give me some  advises to solve the problem.<o:p></o:p></span></font></div> <div class="MsoNormal"><font face="Arial" size="3"><span style="font-size: 12pt; font-family: Arial;" lang="EN-US"><o:p>&nbsp;</o:p></span></font></div> <div class="MsoNormal"><font face="Arial" size="3"><span style="font-size: 12pt; font-family: Arial;" lang="EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; My version is  linux-<st1:chsdate w:st="on" year="1899" month="12" day="30" islunardate="False" isrocdate="False">2.6.23</st1:chsdate>.9 and I use the device tree(dtb) to  booting the kernel. In my bootloader I use the following code to jump to the 
 kernel.<o:p></o:p></span></font></div> <div class="MsoNormal" style="margin-left: 21pt; text-indent: 21pt;"><font face="Arial" size="3"><span style="font-size: 12pt; font-family: Arial;" lang="EN-US">(*image)((bd_t *)dtb_entry,  (unsigned int)image, 0, 0, 0); <o:p></o:p></span></font></div> <div class="MsoNormal"><font face="Arial" size="3"><span style="font-size: 12pt; font-family: Arial;" lang="EN-US"><o:p>&nbsp;</o:p></span></font></div> <div class="MsoNormal"><font face="Arial" size="3"><span style="font-size: 12pt; font-family: Arial;" lang="EN-US">The dtb_entry is the address of dtb  file which in the SDRAM, the image is the kernel entry point. I flashed some  LEDs in my board. So I can make sure the program run to the machine_init() which  is defined in the /arch/powerpc/kernel/setup_32.c</span></font></div><div class="MsoNormal"><font face="Arial" size="3"><span style="font-size: 12pt; font-family: Arial;" lang="EN-US">In order to trace the problem I  search the
 source code. I can find that these information is printed by the  start function which is defined in the /arch/powerpc/boot/main.c.  <o:p></o:p></span></font></div> <div class="MsoNormal"><font face="Arial" size="3"><span style="font-size: 12pt; font-family: Arial;" lang="EN-US">Fourth more I have found that the  kernel call the platform_init which is defined in the  /arch/powerpc/boot/cuboot-83xx.c. looking the file head I have known you are the  author for this file.<o:p></o:p></span></font></div> <div class="MsoNormal"><font face="Arial" size="3"><span style="font-size: 12pt; font-family: Arial;" lang="EN-US">Could you told me how the kernel  call the platform_init function and I hope you can show me the booting process  of the MPC83xx linux or you could give me some document about  it.<o:p></o:p></span></font></div><p>&#32;


      <hr size=1><a href="http://cn.mail.yahoo.com/"> —≈ª¢” œ‰£¨ƒ˙µƒ÷’…˙” œ‰£°</a>
--0-1530653995-1207532117=:18740--
