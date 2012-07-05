Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2CFFF2C01EA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2012 16:02:54 +1000 (EST)
Subject: Re: linux-next: build failure after merge of the kvm-ppc tree
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20120705154929.219789032ef59f9243d0b8a5@canb.auug.org.au>
Date: Thu, 5 Jul 2012 08:02:45 +0200
Message-Id: <92A87EB2-E859-456C-85DE-7F0A4CC5F127@suse.de>
References: <20120705154929.219789032ef59f9243d0b8a5@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel@vger.kernel.org, Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 05.07.2012, at 07:49, Stephen Rothwell wrote:

> Hi Alexander,
>=20
> After merging the kvm-ppc tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>=20
> arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
> arch/powerpc/kernel/exceptions-64s.S:479: Error: wrong number of =
operands
> arch/powerpc/kernel/exceptions-64s.S:486: Error: wrong number of =
operands
> arch/powerpc/kernel/exceptions-64s.S:486: Error: wrong number of =
operands
> arch/powerpc/kernel/exceptions-64s.S:487: Error: wrong number of =
operands
> arch/powerpc/kernel/exceptions-64s.S:487: Error: wrong number of =
operands
> arch/powerpc/kernel/exceptions-64s.S:494: Error: wrong number of =
operands
> arch/powerpc/kernel/exceptions-64s.S:494: Error: wrong number of =
operands
>=20
> Caused by commit bc8cc4993e19 ("PPC: use CURRENT_THREAD_INFO instead =
of
> open coded assembly").  The fact that this patch has problems was =
already
> pointed out on the linuxppc-dev mailing list and it clearly hasn't =
been
> build tested.
>=20
> I have used the version of the kvm-ppc tree from next-20120703 for =
today.

Ah, yes, thanks. I kept the old, broken version in my tree to make sure =
I have the dependencies for (and don't forget) the (hopefully good) =
patches that follow on top, but was planning to replace it once we have =
a new version of the CURRENT_THREAD_INFO one.

Stuart, could you please send a new version of the CURRENT_THREAD_INFO =
patch?


Alex
