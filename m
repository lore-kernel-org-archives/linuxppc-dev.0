From: naushit@softhome.net
Message-ID: <20001213220702.8846.qmail@softhome.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Off topic ...about writing module
Date: Wed, 13 Dec 2000 22:07:02 GMT
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I apologize in advance for writing off topic mail.

I am trying to write some module on my pc. but I dont get output at all.
Here is the sample code that I am trying out


hello.c
-------------------------------------------------
#define MODULE
#define __KERNEL__
#define LINUX

#if CONFIG_VERSIONS==1
#define MOD_VERSIONS
#include <linux/modversions.h>
#endif

#include <linux/module.h>

int init_module(void)
{
	printk("<1> Hello world\n";
	return 0
}

void cleanup_module(void)
{
	printk("<1> bye bye world \n");
}
-----------------------------------------

while I compile , I get following warnings... I dont understand those
warning and I dong know how to get rid of it...any suggestions?
---------------------------------------------
gcc -c hello.c
/tmp/ccMwbBAv.s:Assembler messges:
/tmp/ccMwbBAv.s:8:Warning:Ignoring changed section attributes for .modinfo.

---------------------------------------
now when I load module

#insmod hello.o
#
#lsmod hello
Module		Size 	Usedby
hello		336	o(unused)

Why dont I see hello world on my screen.??? I tried to see console which I
started with xterm -C also.

Please...........Please reply if you know my problem....

Thanking you very much for your time

Regards,
Naushit


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
