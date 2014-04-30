Return-Path: <tommusta@gmail.com>
Received: from mail-yk0-f176.google.com (mail-yk0-f176.google.com
 [209.85.160.176])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0A2BA140080
 for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2014 04:14:35 +1000 (EST)
Received: by mail-yk0-f176.google.com with SMTP id q9so1811402ykb.7
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2014 11:14:32 -0700 (PDT)
Message-ID: <53613D7B.8090001@gmail.com>
Date: Wed, 30 Apr 2014 13:14:19 -0500
From: Tom Musta <tommusta@gmail.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2] powerpc: Add cpu family documentation
References: <1391229347-23026-1-git-send-email-mpe@ellerman.id.au>
 <1391553822.6733.189.camel@snotra.buserror.net>
 <1398840308.5722.5.camel@concordia>
In-Reply-To: <1398840308.5722.5.camel@concordia>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 4/30/2014 1:45 AM, Michael Ellerman wrote:
>> > Are 40x considered booke?
> You tell me.
>  

The original 401, 403 and 405 cores predate the actual existence of what we now call Book E.
But they most certainly contained features that would eventually become Book E (different timers,
software managed TLB, etc.)  For the sake of this diagram, I would say "yes".
