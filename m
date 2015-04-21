Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 98FD61A0205
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 04:12:48 +1000 (AEST)
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0136.outbound.protection.outlook.com [65.55.169.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6638514012F
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2015 04:12:46 +1000 (AEST)
Message-ID: <1429639955.4352.90.camel@freescale.com>
Subject: Re: new way of writing defconfigs for freescale's powerpc platforms
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@tabi.org>
Date: Tue, 21 Apr 2015 13:12:35 -0500
In-Reply-To: <553692DF.2060503@tabi.org>
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
 <1429582152.4352.73.camel@freescale.com> <5535C70A.9070607@codeaurora.org>
 <1429592509.4352.79.camel@freescale.com> <55364FB9.9000106@codeaurora.org>
 <1429638909.4352.87.camel@freescale.com> <553692DF.2060503@tabi.org>
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

On Tue, 2015-04-21 at 13:11 -0500, Timur Tabi wrote:
> On 04/21/2015 12:55 PM, Scott Wood wrote:
> >> >
> >> >Ok, then define a new Kconfig option that merge_config.sh will look for.
> >> >   So in p1_defconfig, there will be this line:
> >> >
> >> >CONFIG_OTHER_DEFCONFIGS=fsl_basic_config
> > If you want to do that go ahead.  In the meantime we'll use the
> > mechanism that already exists.
> 
> Dude, you are not making any sense.  If there is a mechanism that 
> already exists, then what are we talking about?

Using it!

-Scott
