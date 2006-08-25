Return-Path: <GSM909@gmx.de>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 16A2167C30
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 15:28:41 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 25 Aug 2006 07:28:40 +0200
From: "Keinen Namen" <GSM909@gmx.de>
Message-ID: <20060825052840.177160@gmx.net>
MIME-Version: 1.0
Subject: Problems with uaccsess.h
To: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

when I compile my program i got this message

bash-2.05b# make
gcc -O2 -DMODULE -D__KERNEL__ -W -Wall -Wstrict-prototypes
-Wmissing-prototypes -isystem /lib/modules/`uname -r`/build/include
-c -o hello.o hello.c
hello.c:5:25: linux/version: No such file or directory
In file included from hello.c:9:
/usr/include/asm/uaccess.h: In function `verify_area':
/usr/include/asm/uaccess.h:37: error: `CONFIG_TASK_SIZE' undeclared
(first use in this function)
/usr/include/asm/uaccess.h:37: error: (Each undeclared identifier is
reported only once
/usr/include/asm/uaccess.h:37: error: for each function it appears in.)
/usr/include/asm/uaccess.h: In function `copy_from_user':
/usr/include/asm/uaccess.h:280: error: `CONFIG_TASK_SIZE' undeclared
(first use in this function)
/usr/include/asm/uaccess.h: In function `copy_to_user':
/usr/include/asm/uaccess.h:294: error: `CONFIG_TASK_SIZE' undeclared
(first use in this function)
/usr/include/asm/uaccess.h: In function `clear_user':
/usr/include/asm/uaccess.h:313: error: `CONFIG_TASK_SIZE' undeclared
(first use in this function)
/usr/include/asm/uaccess.h: In function `strncpy_from_user':
/usr/include/asm/uaccess.h:327: error: `CONFIG_TASK_SIZE' undeclared
(first use in this function)
/usr/include/asm/uaccess.h: In function `strnlen_user':
/usr/include/asm/uaccess.h:350: error: `CONFIG_TASK_SIZE' undeclared
(first use in this function)

These Header files I have include

#include <linux/module.h>  /* Needed by all modules */
#include <linux/kernel.h>  /* Needed for KERN_ALERT */
#include <linux/slab.h>
#include <linux/delay.h>
#include <linux/version>
#include <linux/init.h>
#include <linux/fs.h>


#include <asm/types.h>
#include <asm/mpc8260.h>
#include <asm/cpm_8260.h>
#include <asm/page.h>

#include <asm/uaccess.h>

My linux is 2.4.25
Need I a patch to correct this ?? I need the funktion copy_to_user.

Regards
Fred


-- 


Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
