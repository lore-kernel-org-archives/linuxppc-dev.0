Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 99AC81A0007
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 06:31:54 +1000 (AEST)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0128.outbound.protection.outlook.com [207.46.100.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 01C09140273
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2015 06:31:53 +1000 (AEST)
Message-ID: <1429561902.4352.29.camel@freescale.com>
Subject: Re: new way of writing defconfigs for freescale's powerpc platforms
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@codeaurora.org>
Date: Mon, 20 Apr 2015 15:31:42 -0500
In-Reply-To: <CAOZdJXVPCNVewAc_=JCMvBG7PccJ1KHnQ5m_WC-GjohFQ_0ZTA@mail.gmail.com>
References: <DM2PR03MB3689ECA6BC27B156BD10F76FCFB0@DM2PR03MB368.namprd03.prod.outlook.com>
 <1429232060.22546.7.camel@ellerman.id.au>
 <1429244000.32545.51.camel@freescale.com>
 <1429251526.22546.8.camel@ellerman.id.au>
 <DM2PR03MB3688B52A469BA5BDD57E3C3FCE30@DM2PR03MB368.namprd03.prod.outlook.com>
 <1429296759.4352.8.camel@freescale.com>
 <DM2PR03MB368C00B6505BB6338074268FCE20@DM2PR03MB368.namprd03.prod.outlook.com>
 <CAOZdJXVPCNVewAc_=JCMvBG7PccJ1KHnQ5m_WC-GjohFQ_0ZTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
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

On Sat, 2015-04-18 at 08:46 -0500, Timur Tabi wrote:
> On Fri, Apr 17, 2015 at 11:53 PM, Lijun Pan <Lijun.Pan@freescale.com> wrote:
> 
> > Have just sent out a patch considering the previous discussion.
> > http://patchwork.ozlabs.org/patch/462249/
> > [PATCH] powerpc/defconfig: new way of writing defconfig
> 
> The ability to merge defconfigs is a feature that's been requested by
> many people for a long time.  Any solution should definitely NOT be
> PowerPC-only.

The ability to merge configs is already there.  We're just talking about
using that functionality.

-Scott
