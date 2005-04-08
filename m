Return-Path: <Marc.Howard@kla-tencor.com>
Received: from ca1mail03.kla-tencor.com (mailout03.kla-tencor.com
	[192.146.1.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7231D67B40
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Apr 2005 05:10:12 +1000 (EST)
Received: from CA1EXBH02.adcorp.kla-tencor.com (ca1exbh02.kla-tencor.com
	[10.60.33.12])
	by ca1mail03.kla-tencor.com (8.12.11/8.12.10) with ESMTP id
	j38IrCcw013411
	for <linuxppc-embedded@ozlabs.org>; Fri, 8 Apr 2005 11:53:31 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 8 Apr 2005 11:48:32 -0700
Message-ID: <91B22F93A880FA48879475E134D6F0BEB9C02A@CA1EXCLV02.adcorp.kla-tencor.com>
From: "Howard, Marc" <Marc.Howard@kla-tencor.com>
To: "Embedded PPC Linux list" <linuxppc-embedded@ozlabs.org>
Subject: RE: cross-compiling under cygwin?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 > -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Dan Malek
> Sent: Friday, April 08, 2005 11:33 AM
> To: Robert P. J. Day
> Cc: Embedded PPC Linux list
> Subject: Re: cross-compiling under cygwin?
>=20
>=20
> On Apr 8, 2005, at 10:13 AM, Robert P. J. Day wrote:
>=20
> >   i've just had a request from a colleague who wants to do all the
> > cross-compilation for our 8xx board on a windows box, rather than
> > linux.
>=20
> Just remember there is lots more to building and developing
> than compiling a kernel.  In addition to the compiler, you need
> lots of support tools.  Once you get a kernel, you have to create
> some kind of file system, of course NFS won't work on Windows,

If I were Catholic I'd have to say a bunch of Hail Mary's for mentioning
this but...

Yes you can run NFS on Windows.  The systems we ship inside our
equipment have a Win2k Server host and the embedded boards hang off of
it.  File exchange is done via NFS.  Micro$oft has a huge free package
called "Windows Services for Unix".  It only runs on Win2k and XP Pro
however.  The other gotcha is that it can only export NTFS file systems,
not FAT32.

It is basically a better cygwin port than cygwin itself.  I say this
because its compiler can compile and run some RPC apps I normally use
natively on the embedded systems.  Cygwin couldn't (missing include
files, etc.).

Now I'm going to wash my mouth out with soap...

Marc W. Howard
