Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 85D0D1A0928
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2015 04:39:27 +1000 (AEST)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0128.outbound.protection.outlook.com [207.46.100.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C20F6140213
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2015 04:39:25 +1000 (AEST)
Message-ID: <1429209555.32545.14.camel@freescale.com>
Subject: Re: new way of writing defconfigs for freescale's powerpc platforms
From: Scott Wood <scottwood@freescale.com>
To: Bob Cochran <ppc@mindchasers.com>
Date: Thu, 16 Apr 2015 13:39:15 -0500
In-Reply-To: <552F3E37.7030507@mindchasers.com>
References: <DM2PR03MB3689ECA6BC27B156BD10F76FCFB0@DM2PR03MB368.namprd03.prod.outlook.com>
 <1428618671.22867.551.camel@freescale.com>
 <552F3E37.7030507@mindchasers.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Pan Lijun-B44306 <Lijun.Pan@freescale.com>,
 Schmitt Richard-B43082 <richard.schmitt@freescale.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-04-16 at 00:44 -0400, Bob Cochran wrote:
> As you probably know, Freescale makes use of the Yocto Project build 
> system for its SDK and submits patches to the SDK at a public 
> meta-fsl-ppc repo at http://git.yoctoproject.org/cgit/cgit.cgi/meta-fsl-ppc/
> 
> I have seen some kernel related patches in the past come across the 
> Yocto Project site that made use of the Yocto Project kernel tools, 
> which includes a process for maintaining kernel configuration fragments. 
>   It sounds like the requirements you have could be met with Yocto's 
> existing process.
> 
> I was hoping to see Freescale continue to move in the direction of using 
> the Yocto kernel tools rather than roll its own solution.
> 
> The Yocto kernel tools make use of description files (*.scc) and 
> configuration fragments (*.cfg).

We do use Yocto for our SDK, but there's always going to be a need to be
able to build kernels outside of Yocto.  The kernel should be
self-contained regarding its own configuration.

merge_config.sh isn't "rolling our own solution". It's a standard kernel
tool.  x86 already has a couple config fragments defined.

-Scott
