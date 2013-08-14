Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id ACE9F2C013A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 14:18:09 +1000 (EST)
Message-ID: <1376453881.4255.57.camel@pasglop>
Subject: Re: Pull request: scottwood/linux.git next
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Wed, 14 Aug 2013 14:18:01 +1000
In-Reply-To: <20130808224501.GA8925@home.buserror.net>
References: <20130808224501.GA8925@home.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-08-08 at 17:45 -0500, Scott Wood wrote:
>       powerpc/e500: Update compilation flags with core specific
> options

This breaks the build for my FSL test configs. For some reason gcc 4.7.3
doesn't know about -mcpu=e5500

Additionally, on 64-bit, that means one can no longer make a kernel that
does both A2 and e5500...

I'm reverting that crap patch, please make such optimizations CONFIG_*
options like power5...7

Cheers,
Ben.
