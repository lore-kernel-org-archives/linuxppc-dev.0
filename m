From: "Elan Feingold" <elan@nxnetworks.com>
To: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Cross GDB and core files
Date: Wed, 5 Sep 2001 16:35:57 -0500
Message-ID: <NDBBLJKOJGKDOFBHNPGEMENACEAA.elan@nxnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm trying to get gdb compiled with host of 386-linux and target of
ppc-linux, mostly for debugging core files.  The ppc_8xx-gdb that came with
hardhat doesn't work, when I run it on a core file I get:

...
warning: couldn't find general purpose registers in core file.
warning: wrong size fpregset struct in core file.
...

And if I try to build gdb from scratch using
"./configure --target=ppc-linux" I get a cross gdb that has no clue how to
read PPC ELF core files.

Help.

-elan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
