Message-ID: <39F856FD.31D39499@mvista.com>
Date: Thu, 26 Oct 2000 09:08:29 -0700
From: Cal Erickson <cal_erickson@mvista.com>
Reply-To: cal_erickson@mvista.com
MIME-Version: 1.0
To: MAC21C@chollian.net
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: QM_MODULES
References: <200010260055.JAA14919@ldap.dacom.co.kr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Have you built the modutils package so that
you can use insmod, modprobe and others?
Cal

MAC21C@chollian.net wrote:

> hello all!!
>
> I have a problum.
>
> I made the test.c file for device driver test.
>
> ========== test.c ===================
> #define MODULE
> #include <linux/kernel.h>
> #include <linux/module.h>
>
> #if CONFIG_MODVERSIONS==1
> #define MODVERSION
> #include <linux/modversions.h>
> #endif
>
> int init_module(void) { printk("Hello, kim\n"); return 0; }
> void cleanup_module(void) { printk("Goodbye Kim\n"); }
> ======================================
> And, compile options
> powerpc-linux-gcc -D__KERNEL__ -O -c test.c
> /tmp/cc8k7ews.s: Assembler messages:
> /tmp/cc8k7ews.s:6: Warning: Ignoring changed section attributes for .modinfo
>
> warning message and i execute the insmod
>
> insmod test.o
> insmod : QM_MODULES function not implmented
>
> I don't know, warning message and error message.
>
> help me~~!!
>

--
===========================================================================
Cal Erickson                 MontaVista Software Inc.
Customer Support Engineer    490 Potrero Avenue
Phone (408) 328-0304         Sunnyvale CA 94085
Fax   (408) 328-9204         e-mail cal_erickson@mvista.com
Pager 877-566-2012           support 1-800-759-8888 pin 202-7489
web http://www.mvista.com    support e-mail: support@mvista.com
eCode: http://cal@work.com.ecode.com
===========================================================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
