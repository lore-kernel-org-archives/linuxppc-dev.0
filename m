Return-Path: <cbf123@mail.usask.ca>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8F3302C034A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jul 2013 02:27:52 +1000 (EST)
Message-ID: <51E02E7D.5050304@mail.usask.ca>
Date: Fri, 12 Jul 2013 10:27:41 -0600
From: Chris Friesen <cbf123@mail.usask.ca>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: error compiling ptrace in current mainline git
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

I'm trying to build current mainline git with gcc version 4.4.1 as a 
cross compiler and I'm getting the following:


   CC      arch/powerpc/kernel/ptrace.o
{standard input}: Assembler messages:
{standard input}:1619: Error: junk at end of line: `1'
{standard input}:2074: Error: junk at end of line: `1'
{standard input}:2742: Error: junk at end of line: `1'
{standard input}:2855: Error: junk at end of line: `1'
{standard input}:2943: Error: junk at end of line: `1'
{standard input}:4699: Error: junk at end of line: `1'
{standard input}:4794: Error: junk at end of line: `1'
{standard input}:4915: Error: junk at end of line: `1'
{standard input}:4985: Error: junk at end of line: `1'
{standard input}:5087: Error: junk at end of line: `1'
make[2]: *** [arch/powerpc/kernel/ptrace.o] Error 1
make[1]: *** [arch/powerpc/kernel] Error 2
make: *** [sub-make] Error 2


Any ideas on how to deal with this?  Is this a code error or a compiler 
error?

Chris
