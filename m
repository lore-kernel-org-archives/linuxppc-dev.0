Message-ID: <C97ABDA0DC2DD511BA400002A50974132804F1@jdry.lanier.com>
From: "Donovan, Chris" <cdonovan@lanier.com>
To: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Status on 403 (Oak) support
Date: Thu, 13 Sep 2001 14:15:13 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm trying to run linux on a board with a 403GCX processor on it. I ran into
an error while trying to compile the kernel as follows:

{standard input}: Assembler messages:
{standard input}:83: Error: unsupported relocation type
{standard input}:84: Error: unsupported relocation type
{standard input}:111: Error: unsupported relocation type
{standard input}:128: Error: unsupported relocation type
{standard input}:145: Error: unsupported relocation type
{standard input}:149: Error: unsupported relocation type
{standard input}:64: Error: unsupported relocation type
make[1]: *** [ppc4xx_pic.o] Error 1
make[1]: Leaving directory `/d/ctemp/src/src-linuxppc_2_4/arch/ppc/kernel'
make: *** [_dir_arch/ppc/kernel] Error 2

While searching the archives I found a thread which mentioned that that
kernel no longer compiles for the 403 processor and there was no mention of
a solution to the problem. Which version of the kernel should work on the
403GCX? Thanks for your help.

Chris

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
