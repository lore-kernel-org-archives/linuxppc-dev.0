Message-ID: <19990916125231.12806.rocketmail@web601.yahoomail.com>
Date: Thu, 16 Sep 1999 14:52:31 +0200 (CEST)
From: sébastien tadéoni <sebastien_tadeoni@yahoo.fr>
Subject: Cross compilation for MPC860
To: linux ppc embedded <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Dear PPC People

I'm student working on a project with linux.
I want to import the linux OS on a MPC860PowerQuick MBX custom card.

I'm working on a PII 400 computer with the linux Mandrake 6.0 release .
I follow the instructions given on the
www.member.home.com/mmporter/cross.html site.

I encount some problems with this procedure for building my own
environment.

I have no problem for installing binutils-2.2.1.0.19a.
But during the make of egcs-core-1.1.2, some command like
'powerpc-linux-ar' were unknown.

I found it in /usr/local/bin, so I assume I must modified the $PATH .

With this manipulation I didn't encount error any more (just some
warning).

Concerning the kernel sources, I took an embedded-2.2.5.tar.gz file on
the linuxppc site.

I don't know where I must put the linux sources directory to, so I make
it in /home (like the two precedent files).

I make menuconfig, dep and then clean with no problems.

During the make zImage I get the following errors:

ppc_ksyms.c:71:'isa_io_base' undeclared here (not in a fonction)

ppc_ksyms.c:71:'initializer element for '--ksymtab_isa_io_base.value'
is not constant,

And the same thing with the variable pci_dram_offset.

Perhaps is there a configuration problem or I didn't install correctly
the powerpc-linux environment for cross development?

On top of that the /usr/local/powerpc_linux/include directory is empty
so that I can't make the ln -s with the include/linux and include/asm
directories(in my linux sources directory) before I want to build the
LibC.

I will appreciate any suggestions and help  from you on this subject.

Thanks in advance.
Have a good day.

Sébastien.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
