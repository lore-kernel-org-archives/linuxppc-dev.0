Return-Path: <oss@buserror.net>
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xhNw535TzDrYj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2018 08:05:52 +1000 (AEST)
Message-ID: <1527804215.30674.35.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Diana Madalina Craciun <diana.craciun@nxp.com>, Michael Ellerman
 <mpe@ellerman.id.au>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Cc: Leo Li <leoyang.li@nxp.com>
Date: Thu, 31 May 2018 17:03:35 -0500
In-Reply-To: <VI1PR0401MB2463C17743BC5C25C2152631FF630@VI1PR0401MB2463.eurprd04.prod.outlook.com>
References: <1526973031-9543-1-git-send-email-diana.craciun@nxp.com>
 <1527020969.30674.13.camel@buserror.net>
 <VI1PR0401MB246345AD11EC8666B7187F8DFF6D0@VI1PR0401MB2463.eurprd04.prod.outlook.com>
 <1527621245.30674.30.camel@buserror.net>
 <87wovjykh8.fsf@concordia.ellerman.id.au>
 <VI1PR0401MB2463C17743BC5C25C2152631FF630@VI1PR0401MB2463.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [RFC PATCH] powerpc/fsl: Add barrier_nospec implementation for
 NXP PowerPC Book E
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-05-31 at 14:35 +0000, Diana Madalina Craciun wrote:
> On 5/31/2018 5:21 PM, Michael Ellerman wrote:
> > 
> > We can add a nospectre_v1 command line option if necessary.
> 
> What about nobarrier_nospec (or similar) instead of nospectre_v1 command
> line? We are not disabling all the v1 mitigations, the masking part will
> remain unchanged.

I think nospectre_v1 makes more sense as it's about the user's intentions
rather than the implementation.  The user is giving the kernel permission to
not defend against spectre v1, and it's up to the implementation which
mitigations (if any) to disable in response to that, same as any other
optimization.

-Scott
