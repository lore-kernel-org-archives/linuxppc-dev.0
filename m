Date: Wed, 26 Apr 2000 11:03:10 -0400
From: Alain Birtz <abz@videotron.ca>
Subject: Kernel recompile: asm-m68k, setup.h and amiga??.h files
To: linuxppc-dev@lists.linuxppc.org
Reply-to: abz@videotron.ca
Message-id: <3907052D.6B4FC950@videotron.ca>
MIME-version: 1.0
Content-type: text/plain; x-mac-creator=4D4F5353; x-mac-type=54455854; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


It seems that everybody tell "You nedd to recompile the kernel..."

So, I try it.

make vmlinux complaint first for setup.h file not in asm-m68k.
To fix it I create a symbolic link to asm-ppc. (Is it OK ?)

But now I get some error involving amiga??.h files.
What can I do ?

Is there instruction about it ?

Is there any kernel source ready to compile ?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
