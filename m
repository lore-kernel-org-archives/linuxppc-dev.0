Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0145.outbound.protection.outlook.com [207.46.163.145])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A5864140099
 for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2014 04:26:40 +1000 (EST)
Message-ID: <1398882391.24575.208.camel@snotra.buserror.net>
Subject: Re: [PATCH v2] powerpc: Add cpu family documentation
From: Scott Wood <scottwood@freescale.com>
To: Tom Musta <tommusta@gmail.com>
Date: Wed, 30 Apr 2014 13:26:31 -0500
In-Reply-To: <53613D7B.8090001@gmail.com>
References: <1391229347-23026-1-git-send-email-mpe@ellerman.id.au>
 <1391553822.6733.189.camel@snotra.buserror.net>
 <1398840308.5722.5.camel@concordia> <53613D7B.8090001@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-04-30 at 13:14 -0500, Tom Musta wrote:
> On 4/30/2014 1:45 AM, Michael Ellerman wrote:
> >> > Are 40x considered booke?
> > You tell me.
> >  
> 
> The original 401, 403 and 405 cores predate the actual existence of what we now call Book E.
> But they most certainly contained features that would eventually become Book E (different timers,
> software managed TLB, etc.)  For the sake of this diagram, I would say "yes".

CONFIG_BOOKE doesn't get set on 40x builds...

-Scott
