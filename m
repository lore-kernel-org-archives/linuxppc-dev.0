Return-Path: <k_shivanii@yahoo.com>
Received: from web32102.mail.mud.yahoo.com (web32102.mail.mud.yahoo.com
	[68.142.207.116]) by ozlabs.org (Postfix) with SMTP id 71BC6679F7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Feb 2006 20:28:45 +1100 (EST)
Message-ID: <20060222092843.64199.qmail@web32102.mail.mud.yahoo.com>
Date: Wed, 22 Feb 2006 01:28:43 -0800 (PST)
From: shivani kirubanandan <k_shivanii@yahoo.com>
Subject: hi problem during kernel compilation
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hello all,

i have encountered this error during kernel
compilation FYI the kernel version is 2.4.26 
powerpc405 and ml300 board specific
plz help me out 
wen i run make zImage

mv zvmlinux ../images/zImage.
mv zvmlinux ../images/zImage.elf
mv: can't stat source zvmlinux
make[2]: *** [zImage] Error 1
make[2]: Leaving directory
`/home/shivani/downloads/linux-2.4.26/arch/ppc/boot/simple'
make[1]: *** [zImage] Error 2
make[1]: Leaving directory
`/home/shivani/downloads/linux-2.4.26/arch/ppc/boot'
make: *** [zImage] Error 2




thanks in advance

shivani

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
