Return-Path: <timur@codeaurora.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F8121A001D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr 2015 23:55:06 +1000 (AEST)
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0E732140273
 for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2015 23:55:05 +1000 (AEST)
Received: from mail-ie0-f175.google.com (mail-ie0-f175.google.com
 [209.85.223.175])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: timur@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 6EC85140052
 for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2015 13:46:52 +0000 (UTC)
Received: by iejt8 with SMTP id t8so90122611iej.2
 for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2015 06:46:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <DM2PR03MB368C00B6505BB6338074268FCE20@DM2PR03MB368.namprd03.prod.outlook.com>
References: <DM2PR03MB3689ECA6BC27B156BD10F76FCFB0@DM2PR03MB368.namprd03.prod.outlook.com>
 <1429232060.22546.7.camel@ellerman.id.au>
 <1429244000.32545.51.camel@freescale.com>
 <1429251526.22546.8.camel@ellerman.id.au>
 <DM2PR03MB3688B52A469BA5BDD57E3C3FCE30@DM2PR03MB368.namprd03.prod.outlook.com>
 <1429296759.4352.8.camel@freescale.com>
 <DM2PR03MB368C00B6505BB6338074268FCE20@DM2PR03MB368.namprd03.prod.outlook.com>
Date: Sat, 18 Apr 2015 08:46:51 -0500
Message-ID: <CAOZdJXVPCNVewAc_=JCMvBG7PccJ1KHnQ5m_WC-GjohFQ_0ZTA@mail.gmail.com>
Subject: Re: new way of writing defconfigs for freescale's powerpc platforms
From: Timur Tabi <timur@codeaurora.org>
To: Lijun Pan <Lijun.Pan@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Richard Schmitt <richard.schmitt@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 17, 2015 at 11:53 PM, Lijun Pan <Lijun.Pan@freescale.com> wrote:

> Have just sent out a patch considering the previous discussion.
> http://patchwork.ozlabs.org/patch/462249/
> [PATCH] powerpc/defconfig: new way of writing defconfig

The ability to merge defconfigs is a feature that's been requested by
many people for a long time.  Any solution should definitely NOT be
PowerPC-only.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
