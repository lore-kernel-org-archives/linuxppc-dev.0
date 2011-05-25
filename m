Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 30F82B6FAD
	for <linuxppc-dev@ozlabs.org>; Wed, 25 May 2011 20:49:14 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP id 06695-03 for <linuxppc-dev@ozlabs.org>;
	Wed, 25 May 2011 11:49:03 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Cannot run  tcl program of PPC460EX
Date: Wed, 25 May 2011 11:47:52 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AD4F@saturn3.aculab.com>
In-Reply-To: <20110525104549.GC22207@zod.rchland.ibm.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>,
	"efti" <eftakhar.chowdhury@yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> On Tue, May 24, 2011 at 11:16:12PM -0700, efti wrote:

> >
> > I am trying to run tcl of my PPC460ex board. I have download the
> > tcl-8.3.3-sol26-sparc-local.gz file. But when I run it I get=20
> > the Syntax error.
>=20
> That tarball seems to indicate it's for both Solaris and Sparc.
> PPC460ex is neither of those.

Which may well mean that the 'syntax error' is from the shell
trying to interpret (as a shell script) a sparc elf binary
that the kernel has failed to 'exec'.

	David
