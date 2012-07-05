Return-Path: <B08248@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 717CC2C01BC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2012 00:20:28 +1000 (EST)
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Alexander Graf <agraf@suse.de>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: RE: linux-next: build failure after merge of the kvm-ppc tree
Date: Thu, 5 Jul 2012 14:20:18 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E150339A388@039-SN1MPN1-002.039d.mgd.msft.net>
References: <20120705154929.219789032ef59f9243d0b8a5@canb.auug.org.au>
 <92A87EB2-E859-456C-85DE-7F0A4CC5F127@suse.de>
In-Reply-To: <92A87EB2-E859-456C-85DE-7F0A4CC5F127@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Alexander Graf [mailto:agraf@suse.de]
> Sent: Thursday, July 05, 2012 1:03 AM
> To: Stephen Rothwell
> Cc: linux-next@vger.kernel.org; linux-kernel@vger.kernel.org; Yoder Stuar=
t-B08248; ppc-dev
> Subject: Re: linux-next: build failure after merge of the kvm-ppc tree
>=20
>=20
> On 05.07.2012, at 07:49, Stephen Rothwell wrote:
>=20
> > Hi Alexander,
> >
> > After merging the kvm-ppc tree, today's linux-next build (powerpc
> > ppc64_defconfig) failed like this:
> >
> > arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
> > arch/powerpc/kernel/exceptions-64s.S:479: Error: wrong number of operan=
ds
> > arch/powerpc/kernel/exceptions-64s.S:486: Error: wrong number of operan=
ds
> > arch/powerpc/kernel/exceptions-64s.S:486: Error: wrong number of operan=
ds
> > arch/powerpc/kernel/exceptions-64s.S:487: Error: wrong number of operan=
ds
> > arch/powerpc/kernel/exceptions-64s.S:487: Error: wrong number of operan=
ds
> > arch/powerpc/kernel/exceptions-64s.S:494: Error: wrong number of operan=
ds
> > arch/powerpc/kernel/exceptions-64s.S:494: Error: wrong number of operan=
ds
> >
> > Caused by commit bc8cc4993e19 ("PPC: use CURRENT_THREAD_INFO instead of
> > open coded assembly").  The fact that this patch has problems was alrea=
dy
> > pointed out on the linuxppc-dev mailing list and it clearly hasn't been
> > build tested.
> >
> > I have used the version of the kvm-ppc tree from next-20120703 for toda=
y.
>=20
> Ah, yes, thanks. I kept the old, broken version in my tree to make sure I=
 have the dependencies for (and
> don't forget) the (hopefully good) patches that follow on top, but was pl=
anning to replace it once we
> have a new version of the CURRENT_THREAD_INFO one.
>=20
> Stuart, could you please send a new version of the CURRENT_THREAD_INFO pa=
tch?

Yes, will send that shortly.

Stuart
