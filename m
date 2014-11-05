Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0F31E1A015D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Nov 2014 17:56:35 +1100 (AEDT)
Message-ID: <1415170594.7440.1.camel@concordia>
Subject: Re: powerpc: Convert power off logic to pm_power_off topic branch
From: Michael Ellerman <mpe@ellerman.id.au>
To: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 05 Nov 2014 17:56:34 +1100
In-Reply-To: <54585FF0.2030609@roeck-us.net>
References: <1415076451.24950.4.camel@concordia>
 <54585FF0.2030609@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, agraf@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-11-03 at 21:11 -0800, Guenter Roeck wrote:
> On 11/03/2014 08:47 PM, Michael Ellerman wrote:
> > I've put the pm_power_off patch in a topic branch:
> >
> >    https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/log/?h=topic/pm-power-off

> Excellent.
> 
> Right now all I can do is to wait for Rafael. He was not happy with earlier versions
> of the series and did not yet comment on the most recent version. Since we are already
> at 3.18-rc3 without making real progress, it may well be that the series is going
> to miss 3.19.

OK.

I'll merge the powerpc bits for 3.19 anyway, so if your stuff misses 3.19 then
it will be even simpler for 3.20.

cheers
