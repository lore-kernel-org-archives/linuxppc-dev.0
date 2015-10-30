Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0119.outbound.protection.outlook.com [157.56.110.119])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F84B1A0B1A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 11:23:50 +1100 (AEDT)
Message-ID: <1446164604.22185.19.camel@freescale.com>
Subject: Re: [ANNOUNCE] kexec-tools 2.0.11-rc1
From: Scott Wood <scottwood@freescale.com>
To: Simon Horman <horms@verge.net.au>
CC: <kexec@lists.infradead.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <linuxppc-dev@lists.ozlabs.org>, Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
Date: Thu, 29 Oct 2015 19:23:24 -0500
In-Reply-To: <20151029234849.GA28689@verge.net.au>
References: <20151029234849.GA28689@verge.net.au>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-10-30 at 08:48 +0900, Simon Horman wrote:
> Hi all,
> 
> I am happy to announce the release of kexec-tools 2.0.11-rc1.
> 
> This is an incremental feature pre-release.
> 
> So long as no serious problems arise I intend to release kexec-tools 2.0.11
> shortly after the release of the v4.3 kernel, which I expect to occur in
> the next week or so.  As such testing of 2.0.11-rc1 would be greatly
> appreciated.
> 
> I do not have any outstanding changes for 2.0.11 at this time.
> And I would like to only accept bug fixes at this time and take take
> features patches once 2.0.11 has been released.

As I previously reported, "ppc64: purgatory: Reset primary cpu endian to big-
endian" breaks book3e, so can http://patchwork.ozlabs.org/patch/527048/ be 
considered for this release?

-Scott
