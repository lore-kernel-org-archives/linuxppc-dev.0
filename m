Return-Path: <sam.d.karp@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by ozlabs.org (Postfix) with ESMTP id D9C53DDF80
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Apr 2008 08:36:11 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so1750974pyg.27
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 07 Apr 2008 15:36:10 -0700 (PDT)
Message-ID: <800687fe0804071536t1f94e1a0x793bd39836dc09d2@mail.gmail.com>
Date: Mon, 7 Apr 2008 16:36:09 -0600
From: "Sam Karp" <sam.d.karp@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Kernel 2.6.23 Error with make bzImage
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_6279_21519902.1207607769765"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_6279_21519902.1207607769765
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've been trying to build the linux 2.6.23 kernel for the PPC405 on the
xilinx ml403.  I copied over my xparameters.h and xparameters_ml40x.h files
and added the following options through menuconfig.
Enable loadable module support: DISABLE
Processor:

   - Type 40x
   - Math emulation: ENABLE
   - IBM 40x options:
      - Machine Type: "Xilinx-ML403"

Platform options:

   - Kernel command line: "console=ttyUL0 root=/dev/ram"

Bus options:

   - PCI support: DISABLE
   - PCCARD (PCMCIA/CardBus) support:
      - PCCARD (PCMCIA/CardBus) support: DISABLE

Drivers

   - Block Devices:
      - Xilinx SystemACE support: ENABLE
   - Character devices:
      - Serial drivers:
         - Xilinx uartlite serial port support: ENABLE
         - Support for console on Xilinx uartlite serial port:
         ENABLE

I then ran make bzImage and got the following errors.  I'm guessing there
are two options I chose that conflict.  Any insight?

 CC arch/powerpc/kernel/swsusp.o
arch/powerpc/kernel/swsusp.c 19 error: redefinition of
'save_processor_state'
include/asm/suspend.h 7  : previous definition of 'save_processor_state' was
here
 arch/powerpc/kernel/swsusp.c 35 error: redefinition of
'restore_processor_state'
include/asm/suspend.h 11  : previous definition of 'restore_processor_state'
was here

Thanks,
Sam

------=_Part_6279_21519902.1207607769765
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I&#39;ve been trying to build the linux 2.6.23 kernel for the PPC405 on the xilinx ml403.&nbsp; I copied over my xparameters.h and xparameters_ml40x.h files and added the following options through menuconfig.&nbsp; 
<li>Enable loadable module support: DISABLE 
<li>Processor: 
<ul>
<li>Type 40x 
<li>Math emulation: ENABLE 
<li>IBM 40x options: 
<ul>
<li>Machine Type: &quot;Xilinx-ML403&quot; </li></ul></li></li></li></ul>
<li>Platform options: 
<ul>
<li>Kernel command line: &quot;console=ttyUL0 root=/dev/ram&quot;&nbsp;</li></ul>
<li>Bus options: 
<ul>
<li>PCI support: DISABLE 
<li>PCCARD (PCMCIA/CardBus) support: 
<ul>
<li>PCCARD (PCMCIA/CardBus) support: DISABLE </li></ul></li></li></ul>
<li>Drivers 
<ul>
<li>Block Devices: 
<ul>
<li>Xilinx SystemACE support: ENABLE </li></ul>
<li>Character devices: 
<ul>
<li>Serial drivers: 
<ul>
<li>Xilinx uartlite serial port support: ENABLE 
<li>Support for console on Xilinx uartlite serial port: ENABLE </li></li></ul></li></ul></li></li></ul></li>
<div>I then ran make bzImage and got the following errors.&nbsp; I&#39;m guessing there are two options I chose that conflict.&nbsp; Any insight?</div>
<div>&nbsp;</div>
<div>&nbsp;CC arch/powerpc/kernel/swsusp.o</div>
<div>arch/powerpc/kernel/swsusp.c 19 error: redefinition of &#39;save_processor_state&#39;</div>
<div>include/asm/suspend.h 7&nbsp; : previous definition of &#39;save_processor_state&#39; was here</div>
<div>
<div>arch/powerpc/kernel/swsusp.c&nbsp;35 error: redefinition of &#39;restore_processor_state&#39;</div>
<div>include/asm/suspend.h&nbsp;11&nbsp; : previous definition of &#39;restore_processor_state&#39; was here&nbsp;</div>
<div>&nbsp;</div>
<div>Thanks,</div>
<div>Sam</div></div></li></li></li></li>

------=_Part_6279_21519902.1207607769765--
