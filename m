Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A6261A0025
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 13:27:09 +1000 (AEST)
Message-ID: <1429586828.9619.8.camel@ellerman.id.au>
Subject: Re: new way of writing defconfigs for freescale's powerpc platforms
From: Michael Ellerman <mpe@ellerman.id.au>
To: Timur Tabi <timur@codeaurora.org>
Date: Tue, 21 Apr 2015 13:27:08 +1000
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
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Lijun Pan <Lijun.Pan@freescale.com>,
 Richard Schmitt <richard.schmitt@freescale.com>
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

Because no one has written a generic way to do it, are you volunteering?

> Besides, wouldn't it make more sense to define a new defconfig type,
> like p1_defconfig.merge, and if you do "make p1_defconfig.merge" it
> knows to call merge_config.sh?

No, we want the existing defconfig names to continue working.

cheers
