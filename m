Return-Path: <timur@tabi.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 111021A01E7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 04:20:27 +1000 (AEST)
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CBC4114011B
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2015 04:20:25 +1000 (AEST)
Message-ID: <553692DF.2060503@tabi.org>
Date: Tue, 21 Apr 2015 13:11:43 -0500
From: Timur Tabi <timur@tabi.org>
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
 <1429592509.4352.79.camel@freescale.com> <55364FB9.9000106@codeaurora.org>
 <1429638909.4352.87.camel@freescale.com>
In-Reply-To: <1429638909.4352.87.camel@freescale.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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

On 04/21/2015 12:55 PM, Scott Wood wrote:
>> >
>> >Ok, then define a new Kconfig option that merge_config.sh will look for.
>> >   So in p1_defconfig, there will be this line:
>> >
>> >CONFIG_OTHER_DEFCONFIGS=fsl_basic_config
> If you want to do that go ahead.  In the meantime we'll use the
> mechanism that already exists.

Dude, you are not making any sense.  If there is a mechanism that 
already exists, then what are we talking about?
