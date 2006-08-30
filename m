Return-Path: <DaveLiu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: RE: atomic operations in user space
Date: Wed, 30 Aug 2006 10:42:56 +0800
Message-ID: <995B09A8299C2C44B59866F6391D263511BB58@zch01exm21.fsl.freescale.net>
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4D0FC82B@zch01exm20.fsl.freescale.net>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Li Yang-r58472" <LeoLi@freescale.com>, <linuxppc-embedded@ozlabs.org>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[snip]
> >=20
> > Is this your reason we cannot do atomic operation in user space?
> >=20
> > How about the kernel space? You can image it.
> > The context switching as above also happen in kernel space,=20
> Why we can=20
> > do atomic operation in kernel space, not do in user space?
> >
>=20
> There are substantial different between kernel and user=20
> control path.  First, interrupt can't be interrupted by user=20
> process.  Second, context switch can be explicitly controlled=20
> in kernel, but not in user space.

I agree this, but from the processor's view, the context switch
is the same to user space and kernel space. The exception
control flow only happen at exception interrupt.=20

What is different you point ?

> > You are assuming the context switching cause the reservation broken.
> > but we can do atomic operation in kernel space.  The=20
> context switching=20
> > really is the execption of processor, If we can clear the wrong=20
> > RESERVATION before exception return, I think we can solve this=20
> > problem. We can dummy stwcx. before exception return or the=20
> processor=20
> > automaticly clear the reservation in exception.
>=20
> I assume stwcx is a costing instruction, and I don't see such=20
> code indeed.
