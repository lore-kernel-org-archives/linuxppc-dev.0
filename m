Message-ID: <40B0ADDE.4000606@g-house.de>
Date: Sun, 23 May 2004 15:57:50 +0200
From: Christian Kujau <evil@g-house.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: minimum required binutils for ppc32?
References: <20040523095826.GA10105@lst.de>
In-Reply-To: <20040523095826.GA10105@lst.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Christoph Hellwig schrieb:
| What's the minimum required binutils version for ppc32 these days?
|
| The debian kernel package ups it from 2.12.1 to 2.12.90.0.7, i.e. from
| the first 2.12 maintaince release to one of hjl's later releases and
| I wonder why it does that.  Either it's bogus and should be be dropped
| or we should up it in mainline.

well, the version of binutils in debian/woody is still
pool/main/b/binutils/binutils_2.12.90.0.1-4_powerpc.deb.
and kernel-source packages usually only depend on "binutils" from the
same release (e.g. "stable"), no version number is given in "Depends:"

the unstable changelog reveals:
binutils (2.12.90.0.7-1) unstable; urgency=low


~  * New upstream version (synced with CVS 2002-04-23).
~  * Upstream: ELF EH frame bug fix
~  * Upstream: MIPS ELF visibility bug fix
~  * Upstream: Bug fixes for ELF/sparc
~  * Upstream: Bug fixes for ELF/cris
~  * Upstream: Fix linking a.out relocatable files
~    with ELF
~  * Upstream: Fix a PPC altivec assembler bug
~  * Numerous upstream changes since I have
~    deliberately not updated in awhile so that
~    I could stabilise the package for woody
~    release
~  * Fixed a glaring typo in the Debian additions
~    to the version string.
~  * Upstream incorporated --oformat
~    documentation patch; removed.
~  * Added a patch from upstream involving
~    relative relocs on Alpha
~  * Removed configure.info-[1-3] from -doc
~    (closes: Bug#146205)
- --------------
so, there is some "PPC altivec assembler bug", but no bug#, don't what
this is about.

speaking of binutils, i'm currently unable to compile binutils-2.14.92
for ppc32 (hence the posting of "Error: Unrecognized opcode: `dssall'"
in linuxppc-dev)...


Christian.
- --
BOFH excuse #426:

internet is needed to catch the etherbunny

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
