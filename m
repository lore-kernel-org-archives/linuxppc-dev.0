Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Date: Sat, 29 Oct 2005 01:11:13 +0200
References: <17250.8725.358204.62510@cargo.ozlabs.ibm.com>
In-Reply-To: <17250.8725.358204.62510@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510290111.13867.arnd@arndb.de>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org
Subject: Re: Patches for 2.6.15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Freedag 28 Oktober 2005 15:05, Paul Mackerras wrote:
> If anyone has patches for arch/ppc{,64} and include/asm-ppc{,64} that
> they would like to see go upstream now that 2.6.14 is out, other than
> patches that are already in the powerpc-merge tree, please let me
> know. =A0I am planning to ask Linus to pull the powerpc-merge tree
> shortly, and that will probably break your patches.

Out of my spufs patches, I'd like to have at least the reservation
for my two system call numbers in there so we don't get any conflicts
on that front. The patch follows in another mail.

=46rom my point of view, the spufs itself could go in at this point,
but I have the feeling that the real concerns from other people
will come up at the moment that I post them for inclusion.=20

Andrew, are you ok with including spufs in -mm when the merge
tree is upstream?

> If possible, I'd like to get to the point where we can remove
> arch/ppc64 entirely by the end of the 2-week merge window for 2.6.15.

Ok, I'll do a new patch to move over the BPA files then to get
my stuff out of the way ASAP.

	Arnd <><
