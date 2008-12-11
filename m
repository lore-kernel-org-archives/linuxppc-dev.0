Return-Path: <ron_madrid@sbcglobal.net>
Received: from web83507.mail.sp1.yahoo.com (web83507.mail.sp1.yahoo.com
	[216.252.120.163]) by ozlabs.org (Postfix) with SMTP id E69CEDE03A
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 10:55:15 +1100 (EST)
Date: Thu, 11 Dec 2008 15:48:34 -0800 (PST)
From: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Problem building kernel
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <683138.71397.qm@web83507.mail.sp1.yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello all,

I got the latest kernel from git://git.denx.de/linux-2.6-denx.git and after
configuring with menuconfig I am seeing these errors.  I feel like this
could be something simple that I am just unaware of, but I'm not sure
and haven't been able to find anything useful when doing a web search.

Any ideas?  What other information would be helpful?

  BOOTCC  arch/powerpc/boot/redboot-83xx.o
  BOOTCC  arch/powerpc/boot/cuboot-sam440ep.o
  BOOTCC  arch/powerpc/boot/cuboot-acadia.o
{standard input}: Assembler messages:
{standard input}:278: Error: Unrecognized opcode: `mtdcr'
{standard input}:282: Error: Unrecognized opcode: `mfdcr'
{standard input}:289: Error: Unrecognized opcode: `mtdcr'
{standard input}:293: Error: Unrecognized opcode: `mfdcr'
{standard input}:312: Error: Unrecognized opcode: `mtdcr'
{standard input}:316: Error: Unrecognized opcode: `mfdcr'
make[2]: *** [arch/powerpc/boot/cuboot-acadia.o] Error 1
make[1]: *** [zImage] Error 2
make: *** [sub-make] Error 2

Ron
