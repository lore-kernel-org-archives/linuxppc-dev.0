Date: Tue, 9 Dec 2003 11:06:31 +0100
To: linuxppc-dev@lists.linuxppc.org
Subject: apple mach-o library and ppc kernel modules.
Message-ID: <20031209100631.GA5551@iliana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I am trying to make a build of the bewan adsl pci modem driver for
powerpc.

The driver in question comes with a proprietary binary only soft-ADSL
library, and the driver actually provides a wrapper on top of this one.

Bewan doesn't actually have access to the source of it, and i was not
able to convince them to convince STm to make a ppc build of the
soft-ADSL library.

That said, they have a macos X copy of this binary library, which is a :

  Mach-O object ppc

If it would have been an elf object file, using it in the kernel would
have been possible, but i don't know how (and if) it is possible to
convert this Mach-O object file to something usable by the kernel.

Other alternatives would be to use some kind of emulator to run the x86
version of the library, but i guess this is not possible kernel-side.

Any hint of information about this would be welcome. Or simply
links documentation on the Mach-O object format too, but i guess google
will help me out there.

BTW, it is also compiled with an apple patched gcc 2.95, so i guess i
will run in problems when using a gcc 3.3 compiled kernel, but probably
in a later iteration of the macos X build, they will also use gcc 3.3,
since apple is using that now.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
