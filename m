From: nunninger@web.de
To: linuxppc-embedded@lists.linuxppc.org
Date: Thu, 1 Mar 2001 16:27:38 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: including debugging symbols in assembler files
Reply-To: nunninger@web.de
Message-ID: <3A9E787A.21141.ACAA65C@localhost>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

Once more I got a question to ask.

I've installed BDM4GDB recently. It seems to work just fine.
I can do all the things one expect from a debugger like
reading/wrinting memory, setting registers, loading linux and start
linux.
However there seems to be a problem with the debugging
information which is included in the binary file. For example I can
not set a breakpoint inside an assembler file like
b	start
When I'm trying to do so I get a error message stating there is no
symbol information. Also when I type "list" right at the beginning of
the binary file I can not see the assembler code but instead main.c
is displayed. Also when typing "list files" I see all kind of *.h and
*.c files but no assembler files.

When compiling I'm using the flag -g in the CFLAGS in the top level
Makefile as well as in /mbxboot. I'm not sure wheter this includes
debugging information in assembler files as well. So I added also -
Wa,--gstabs in the Makefile of /mbxboot to ask the assembler
explicitly to include debugging information. Like this there is
included some more information. However gdb seems not to
understant it. For instance the filename which should be head.S is
some kind of random (?) name like "ccwHvFaT.S". Also I saw the
error message unknown debugging information in GDB.

Please could someone point me out how I sould include debugging
information such that I can work properly with GDB and BDM4GDB.

Thanks a lot
	Stefan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
