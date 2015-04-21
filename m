Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0A2121A0205
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 12:09:33 +1000 (AEST)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0104.outbound.protection.outlook.com [207.46.100.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 667CF1401AD
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2015 12:09:31 +1000 (AEST)
Message-ID: <1429582152.4352.73.camel@freescale.com>
Subject: Re: new way of writing defconfigs for freescale's powerpc platforms
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@codeaurora.org>
Date: Mon, 20 Apr 2015 21:09:12 -0500
In-Reply-To: <CAOZdJXWnh3PbZ8FRFzJ9=h+bFF3_Uqeu=hzoqD6GYF8acQ21kQ@mail.gmail.com>
References: <DM2PR03MB3689ECA6BC27B156BD10F76FCFB0@DM2PR03MB368.namprd03.prod.outlook.com>
 <1429232060.22546.7.camel@ellerman.id.au>
 <1429244000.32545.51.camel@freescale.com>
 <1429251526.22546.8.camel@ellerman.id.au>
 <DM2PR03MB3688B52A469BA5BDD57E3C3FCE30@DM2PR03MB368.namprd03.prod.outlook.com>
 <1429296759.4352.8.camel@freescale.com>
 <DM2PR03MB368C00B6505BB6338074268FCE20@DM2PR03MB368.namprd03.prod.outlook.com>
 <CAOZdJXVPCNVewAc_=JCMvBG7PccJ1KHnQ5m_WC-GjohFQ_0ZTA@mail.gmail.com>
 <1429561902.4352.29.camel@freescale.com>
 <CAOZdJXWnh3PbZ8FRFzJ9=h+bFF3_Uqeu=hzoqD6GYF8acQ21kQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Richard Schmitt <richard.schmitt@freescale.com>,
 Lijun Pan <Lijun.Pan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-04-20 at 21:02 -0500, Timur Tabi wrote:
> On Mon, Apr 20, 2015 at 3:31 PM, Scott Wood <scottwood@freescale.com> wrote:
> >
> >
> > The ability to merge configs is already there.  We're just talking about
> > using that functionality.
> 
> Why do you need a powerpc-specific way to use merge_config.sh?  Other
> architectures have the same problem with defconfigs.

What are you perceiving as "powerpc-specific" about what we're
proposing?  Are you complaining about the actual content of which
fragments to use to produce which defconfigs going in arch/powerpc?

> Besides, wouldn't it make more sense to define a new defconfig type,
> like p1_defconfig.merge, and if you do "make p1_defconfig.merge" it
> knows to call merge_config.sh?

That's already there.  "make <foo>.config".

-Scott
