Return-Path: <vancasperz@yahoo.com.cn>
Received: from web15610.mail.cnb.yahoo.com (web15610.mail.cnb.yahoo.com
	[202.165.102.64]) by ozlabs.org (Postfix) with SMTP id 35065679FC
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 13:43:37 +1000 (EST)
Message-ID: <20060623034336.79924.qmail@web15610.mail.cnb.yahoo.com>
Date: Fri, 23 Jun 2006 11:43:36 +0800 (CST)
From: Zhou Rui <vancasperz@yahoo.com.cn>
Subject: Re: Problem for "insmod: unresolved symbol printk"
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20060622174810.GA16973@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1253638844-1151034216=:78962"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-1253638844-1151034216=:78962
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Hi,
    My host machine kernel was 2.4.28 and the PowerPC board was 2.4.25-rthal5. I followed  the Standard Makefile for 2.4(<=) kernels on the page http://kernelnewbies.org/FAQ/LinuxKernelModuleCompile?highlight=%28insmod%29, and do some changes based on my situation:

TARGET := hello
INCLUDE := -I/lib/modules/2.4.25-rthal5/build/include
CFLAGS := -O2 -Wall -DMODULE -D__KERNEL__ -DLINUX
CC := powerpc-linux-gcc

${TARGET}.o: ${TARGET}.c
        $(CC) $(CFLAGS) ${INCLUDE} -c ${TARGET}.c

The problem is still "insmod: unresolved symbol printk". But when I logged in the PowerPC board, and # fgrep 'printk' /proc/ksyms, there was "c0015500 printk_Rdd132261".



Olof Johansson <olof@lixom.net> ： On Thu, Jun 22, 2006 at 10:31:56PM +0800, Zhou Rui wrote:
> Hi, all
>     I'm a newbie for linuxppc. I've tried to write a simple hello.c as a kernel module.

Hi,

http://kernelnewbies.org/  should have information on kernel module
basics, and where to find help if you still have problems.


-Olof



Zhou Rui
Distributed & Embedded System Lab
School of Information Science & Engineering
Lanzhou University, P. R. China
http://dslab.lzu.edu.cn/~zr/
 		
---------------------------------
 Mp3疯狂搜-新歌热歌高速下   
--0-1253638844-1151034216=:78962
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

Hi,<br />&nbsp;&nbsp;&nbsp; My host machine kernel was 2.4.28 and the PowerPC board was 2.4.25-rthal5. I followed&nbsp; the Standard Makefile for 2.4(&lt;=) kernels<span style="font-weight: bold;"> </span>on the page http://kernelnewbies.org/FAQ/LinuxKernelModuleCompile?highlight=%28insmod%29, and do some changes based on my situation:<br /><br />TARGET := hello<br />INCLUDE := -I/lib/modules/2.4.25-rthal5/build/include<br />CFLAGS := -O2 -Wall -DMODULE -D__KERNEL__ -DLINUX<br />CC := powerpc-linux-gcc<br /><br />${TARGET}.o: ${TARGET}.c<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(CC) $(CFLAGS) ${INCLUDE} -c ${TARGET}.c<br /><br />The problem is still "insmod: unresolved symbol printk". But when I logged in the PowerPC board, and # fgrep 'printk' /proc/ksyms, there was "c0015500 printk_Rdd132261".<br /><br /><br /><br /><b><i>Olof Johansson &lt;olof@lixom.net&gt;</i></b> ：<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px;
 padding-left: 5px;"> On Thu, Jun 22, 2006 at 10:31:56PM +0800, Zhou Rui wrote:<br />&gt; Hi, all<br />&gt;     I'm a newbie for linuxppc. I've tried to write a simple hello.c as a kernel module.<br /><br />Hi,<br /><br />http://kernelnewbies.org/  should have information on kernel module<br />basics, and where to find help if you still have problems.<br /><br /><br />-Olof<br /></blockquote><br /><BR><BR>Zhou Rui<br>Distributed &amp; Embedded System Lab<br>School of Information Science &amp; Engineering<br>Lanzhou University, P. R. China<br>http://dslab.lzu.edu.cn/~zr/<p>&#32;
		<hr size=1><a href="http://music.yahoo.com.cn/?source=mail_mailbox_footer" target=blank> 
Mp3疯狂搜-新歌热歌高速下 
</a>
 
 

--0-1253638844-1151034216=:78962--
