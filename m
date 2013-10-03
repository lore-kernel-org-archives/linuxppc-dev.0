Return-Path: <bogvlad1@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0253.outbound.messaging.microsoft.com [213.199.154.253])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 87C4B2C0094
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 19:35:46 +1000 (EST)
Received: from mail182-db9 (localhost [127.0.0.1])	by
 mail182-db9-R.bigfish.com (Postfix) with ESMTP id C84131201CB	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 09:35:40 +0000 (UTC)
Received: from DB9EHSMHS019.bigfish.com (unknown [10.174.16.237])	by
 mail182-db9.bigfish.com (Postfix) with ESMTP id C8FB53C0053	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2013 09:35:39 +0000 (UTC)
From: Vlad Bogdan-BOGVLAD1 <bogvlad1@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Kushwaha Prabhakar-B32579
 <B32579@freescale.com>
Subject: RE: [PATCH 1/2][v7] powerpc/mpc85xx:Add initial device tree support
 of T104x
Date: Thu, 3 Oct 2013 09:35:35 +0000
Message-ID: <FE5A3326D3B04741A186240B1F46FA8014DE9EA4@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1380524042-13720-1-git-send-email-prabhakar@freescale.com>
 <1380570471.24959.517.camel@snotra.buserror.net>
 <524A40F4.9040406@freescale.com>
 <1380657408.10618.52.camel@snotra.buserror.net>
In-Reply-To: <1380657408.10618.52.camel@snotra.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Aggrwal Poonam-B10812 <B10812@freescale.com>,
 Stefanescu Razvan-B44149 <B44149@freescale.com>,
 Jain Priyanka-B32167 <B32167@freescale.com>,
 Sethi Varun-B16395 <B16395@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Marginean Alexandru-R89243 <R89243@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,
Yes the driver owner exist. We have a proposal of l2 switch bindings.
Will send a patch with the l2 switch bindings added on top of existing T104=
x proposal.

Regards,

Bogdan V

-----Original Message-----
From: Linuxppc-dev [mailto:linuxppc-dev-bounces+bogdan.vlad=3Dfreescale.com=
@lists.ozlabs.org] On Behalf Of Scott Wood
Sent: Tuesday, October 01, 2013 22:57
To: Kushwaha Prabhakar-B32579
Cc: Sethi Varun-B16395; linuxppc-dev@lists.ozlabs.org; Aggrwal Poonam-B1081=
2; Jain Priyanka-B32167
Subject: Re: [PATCH 1/2][v7] powerpc/mpc85xx:Add initial device tree suppor=
t of T104x

On Tue, 2013-10-01 at 08:56 +0530, Prabhakar Kushwaha wrote:
> On 10/01/2013 01:17 AM, Scott Wood wrote:
> > On Mon, 2013-09-30 at 12:24 +0530, Prabhakar Kushwaha wrote:
> >>      - Removed l2switch. It will be added later
> > Why?
>
> I am not aware of bindings required for l2switch as we are not working
> on the driver.
> Earlier I thought of putting a place holder. but as you suggested to
> put bindings in documentation.
> It will be good if it is put by actual driver owner.

Is there a reason to believe the binding will be complicated?

Does any such "driver owner" exist yet?


> >> +sata@220000 {
> >> +                  fsl,iommu-parent =3D <&pamu0>;
> >> +                  fsl,liodn-reg =3D <&guts 0x550>; /* SATA1LIODNR */ =
}; /include/
> >> +"qoriq-sata2-1.dtsi"
> >> +sata@221000 {
> >> +                  fsl,iommu-parent =3D <&pamu0>;
> >> +                  fsl,liodn-reg =3D <&guts 0x554>; /* SATA2LIODNR */ =
};
> > Whitespace
>
> do we have any scripts which check for whitespace as checkpatch never
> give any warning/error.
> it is a very silly mistake which I am doing continuously :(

checkpatch doesn't check dts files.

> >> +/include/ "t1040si-post.dtsi"
> > Should at least have a comment indicating that eventually this
> > should hold the l2 switch node.
>
> yes. Ideally it should be.
> but if I put a comment then I believe this patch will not be completed.
> it will think as a RFC.
> as I believe putting of TODO is generally for RFC patches.

As is, one would wonder why the separate file exists at all.

The TODO is there whether you have a comment acknowledging it or not. :-)

-Scott



_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev
