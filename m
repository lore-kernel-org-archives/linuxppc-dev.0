Return-Path: <timur@codeaurora.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 626D01A0025
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 23:25:19 +1000 (AEST)
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7E422140083
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2015 23:25:18 +1000 (AEST)
Message-ID: <55364FB9.9000106@codeaurora.org>
Date: Tue, 21 Apr 2015 08:25:13 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: new way of writing defconfigs for freescale's powerpc platforms
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
 <1429592509.4352.79.camel@freescale.com>
In-Reply-To: <1429592509.4352.79.camel@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Scott Wood wrote:
> We want single-name config targets to still work from the user's
> perspective, but we want to reduce the (often imperfect) duplication
> under the hood.

Ok, then define a new Kconfig option that merge_config.sh will look for. 
  So in p1_defconfig, there will be this line:

CONFIG_OTHER_DEFCONFIGS=fsl_basic_config

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
