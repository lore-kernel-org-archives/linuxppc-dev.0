Return-Path: <timur@codeaurora.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 351011A0025
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 12:02:14 +1000 (AEST)
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D82031401E7
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2015 12:02:12 +1000 (AEST)
Received: from mail-ie0-f180.google.com (mail-ie0-f180.google.com
 [209.85.223.180])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: timur@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id A8525140624
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2015 02:02:09 +0000 (UTC)
Received: by iecrt8 with SMTP id rt8so3851683iec.0
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2015 19:02:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1429561902.4352.29.camel@freescale.com>
References: <DM2PR03MB3689ECA6BC27B156BD10F76FCFB0@DM2PR03MB368.namprd03.prod.outlook.com>
 <1429232060.22546.7.camel@ellerman.id.au>
 <1429244000.32545.51.camel@freescale.com>
 <1429251526.22546.8.camel@ellerman.id.au>
 <DM2PR03MB3688B52A469BA5BDD57E3C3FCE30@DM2PR03MB368.namprd03.prod.outlook.com>
 <1429296759.4352.8.camel@freescale.com>
 <DM2PR03MB368C00B6505BB6338074268FCE20@DM2PR03MB368.namprd03.prod.outlook.com>
 <CAOZdJXVPCNVewAc_=JCMvBG7PccJ1KHnQ5m_WC-GjohFQ_0ZTA@mail.gmail.com>
 <1429561902.4352.29.camel@freescale.com>
Date: Mon, 20 Apr 2015 21:02:08 -0500
Message-ID: <CAOZdJXWnh3PbZ8FRFzJ9=h+bFF3_Uqeu=hzoqD6GYF8acQ21kQ@mail.gmail.com>
Subject: Re: new way of writing defconfigs for freescale's powerpc platforms
From: Timur Tabi <timur@codeaurora.org>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Timur Tabi <timur@codeaurora.org>,
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

On Mon, Apr 20, 2015 at 3:31 PM, Scott Wood <scottwood@freescale.com> wrote:
>
>
> The ability to merge configs is already there.  We're just talking about
> using that functionality.

Why do you need a powerpc-specific way to use merge_config.sh?  Other
architectures have the same problem with defconfigs.

Besides, wouldn't it make more sense to define a new defconfig type,
like p1_defconfig.merge, and if you do "make p1_defconfig.merge" it
knows to call merge_config.sh?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
