Return-Path: <raul.moreno@telvent.abengoa.com>
Received: from c07.abengoa.com (envio.abengoa.com [217.15.37.68])
	by ozlabs.org (Postfix) with ESMTP id 41619DDE0C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Sep 2007 00:23:49 +1000 (EST)
In-Reply-To: <f8f856500709130705t2109e559v19f0ffac318a4756@mail.gmail.com>
Subject: Re: Informations about mem and proc environment between bootloader and
	kernel
To: "fabien boucher" <fabien.fb@gmail.com>
Message-ID: <OFD1DD4A9B.76E5C9ED-ONC1257355.004E8905-C1257355.004F16D9@abengoa.com>
Date: Thu, 13 Sep 2007 16:23:59 +0200
From: raul.moreno@telvent.abengoa.com
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded-bounces+raul.moreno=telvent.abengoa.com@ozlabs.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Fabien,

you should download the U-boot sources from sourceforge.net. There is a=

README file there where you can read about porting U-boot.
The porting to a custom board of U-boot is easier when your cpu is incl=
ude,
like in your case (mpc8xx). Basically you have to create a new entry in=

board directory. There you have to insert the initialization code for y=
our
flash, sdram and other devices. You also have to make a file as the one=
s in
/include/configs/ with your configuration board.

It is essential to have correct environment variables when Linux takes =
the
control.
If you use the u-boot command "bootm" in order to boot Linux, the file
where U-Boot transfer the control to Linux is /common/cmd_bootm.c.

Moreover I would recommend you a book which explains many things regard=
ing
porting Linux (and U-boot):
Embedded Linux Primer: A practical, real-world  approach.

Cheers,

Ra=FAl Moreno



Ra=FAl Moreno Beltr=E1n
Telvent Energ=EDa, S. A.
Divisi=F3n de Tecnolog=EDa. Desarrollo Software
Tlfo: 954935670



"fabien boucher" <fabien.fb@gmail.com>
"fabien boucher"
Enviado por:
linuxppc-embedded-bounces+raul.moreno=3Dtelvent.abengoa.com@ozlabs.org
13/09/2007 16:05
                                                                       =
                                                
 Para:   linuxppc-embedded@ozlabs.org                                  =
                                                
                                                                       =
                                                
 cc:                                                                   =
                                                
                                                                       =
                                                
 Asunto: Informations about mem and proc environment between bootloader=
 and     kernel                                 
                                                                       =
                                                





And I need some help for my project (I'm in internship) to port linux o=
n a
custom board.
This board has been developped by the company where i'm doing the inter=
ship
and it's
based on a MPC875 with RAM and Flash chips and several other devices.
Currently the board run with a BSP developped
by the company's developpers, the BSP launch Psos.
This BSP is able to decompress an image and load it in RAM.
I plan to use U-boot to be more able to boot a kernel but as it's not a=

common
board so it's not initialy supported by U-boot. So I have two choices f=
irst
use the BSP with some changes to adapt it for loading the Linux kernel =
or
using U-boot.
I'm looking for informations about the memory and processor environment=

needed by linux to
boot properly for evaluate whether the use of a customize BSP is the
easiest way against
the port of a new board under U-boot. So if someone know where i can fo=
und
those informations
concerning the step between where the boot program have control of the =
cpu
and where Linux
take control.

Thank you,
Fabien
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded=
