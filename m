Message-ID: <A33AEFDC2EC0D411851900D0B73EBEF73D9B90@NAPA>
From: Hua Ji <hji@netscreen.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: About sdata and sbss symbols.
Date: Tue, 3 Apr 2001 21:36:20 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hi, folks,

I met a problem when using the powerpc-eabi-gcc, which I built with gnu
source.

When I built my codes, I opened the "-G 4" option, which means, sdata and
sbss sections
will be enabled for containing all 4*8 data(for example, pointers,
integers).However, when I look at the map file, I found the symbols in sdata
and sbss are messed up. For example, variable A and variable B even have the
SAME ADDRESSES, allocated by the linker.

I tried to disable the sdata and sbss section by using compiler option
"-msdata=none" and then
all symbols went to data and bss sections and the system works well.

I guess I missed some points of how to use gcc for (embedde) power pc
system.Could anyone know?
Thanks in advance. BTW, my target is powerpc 405GP and I am using gcc
version 2.95.2 19991024 (release)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
