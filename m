Return-Path: <vancasperz@yahoo.com.cn>
Received: from web15601.mail.cnb.yahoo.com (web15601.mail.cnb.yahoo.com
	[202.165.102.55]) by ozlabs.org (Postfix) with SMTP id A826B67A3A
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 00:38:38 +1000 (EST)
Message-ID: <20060622143156.39031.qmail@web15601.mail.cnb.yahoo.com>
Date: Thu, 22 Jun 2006 22:31:56 +0800 (CST)
From: Zhou Rui <vancasperz@yahoo.com.cn>
Subject: Problem for "insmod: unresolved symbol printk"
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-982979180-1150986716=:36987"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-982979180-1150986716=:36987
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Hi, all
    I'm a newbie for linuxppc. I've tried to write a simple hello.c as a kernel module.

/*hello.c*/
#ifndef MODULE
#define MODULE
#endif

#ifndef __KERNEL__
#define __KERNEL__
#endif

#include <linux/module.h>
#include <linux/kernel.h>

int init_module(void)
{
        printk("Hello world 1.\n");
        return 0;
}

void cleanup_module(void)
{
        printk("Goodbye world 1.\n");
}

I wrote the code on a machine with Slackware installed. There was a PowerPC405EP board connected to the machined with NFS used. On the PowerPC board, the kernel is linuxppc-2.4.25-rthal5 and can be logged in via telnet. On the machine, there was also a toolchain for PowerPC and there were a series of commands beginning with "powerpc-linux-" existing. I've tried to cross-compile the source file with "powerpc-linux-gcc -c hello.c" or "powerpc-linux-gcc -c -DMODVERSIONS -I/usr/src/linuxppc-2.4.25/include hello.c" for PowerPC. But when I telneted into the board and run "insmod hello.o" on the PowerPC board, there always was "insmod: unresolved symbol printk". So would anyone give me some advice about the problem? Thank you very much.

 		
---------------------------------
 ÑÅ»¢Ãâ·ÑÓÊÏä-3.5GÈÝÁ¿£¬20M¸½¼þ
--0-982979180-1150986716=:36987
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

Hi, all<br>&nbsp;&nbsp;&nbsp; I'm a newbie for linuxppc. I've tried to write a simple hello.c as a kernel module.<br><br>/*hello.c*/<br>#ifndef MODULE<br>#define MODULE<br>#endif<br><br>#ifndef __KERNEL__<br>#define __KERNEL__<br>#endif<br><br>#include &lt;linux/module.h&gt;<br>#include &lt;linux/kernel.h&gt;<br><br>int init_module(void)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk("Hello world 1.\n");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>}<br><br>void cleanup_module(void)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk("Goodbye world 1.\n");<br>}<br><br>I wrote the code on a machine with Slackware installed. There was a PowerPC405EP board connected to the machined with NFS used. On the PowerPC board, the kernel is linuxppc-2.4.25-rthal5 and can be logged in via telnet. On the machine, there was also a toolchain for PowerPC and there were a series of commands beginning with "powerpc-linux-" existing. I've tried to cross-compile
 the source file with "powerpc-linux-gcc -c hello.c" or "powerpc-linux-gcc -c -DMODVERSIONS -I/usr/src/linuxppc-2.4.25/include hello.c" for PowerPC. But when I telneted into the board and run "insmod hello.o" on the PowerPC board, there always was "insmod: unresolved symbol printk". So would anyone give me some advice about the problem? Thank you very much.<br><p>&#32;
		<hr size=1><a href="http://cn.mail.yahoo.com/" target=blank> 
ÑÅ»¢Ãâ·ÑÓÊÏä-3.5GÈÝÁ¿£¬20M¸½¼þ
</a>
--0-982979180-1150986716=:36987--
