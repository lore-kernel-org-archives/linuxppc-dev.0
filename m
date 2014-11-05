Return-Path: <linux@roeck-us.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E4DE01A034B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Nov 2014 01:24:34 +1100 (AEDT)
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0EBC3140098
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2014 01:24:33 +1100 (AEDT)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1Xm1Vf-001Tpz-7w
 for linuxppc-dev@ozlabs.org; Wed, 05 Nov 2014 14:24:31 +0000
Date: Wed, 5 Nov 2014 06:24:23 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc: Convert power off logic to pm_power_off topic branch
Message-ID: <20141105142423.GA23392@roeck-us.net>
References: <1415076451.24950.4.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1415076451.24950.4.camel@concordia>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, agraf@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 04, 2014 at 03:47:31PM +1100, Michael Ellerman wrote:
> Hi Guenter,
> 
> I've put the pm_power_off patch in a topic branch:
> 
>   https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/log/?h=topic/pm-power-off
> 
> I'll pull this into my next when I open it.
> 
> Let me know if there's any issue with it.
> 
Seems to work fine. I rebased my branch on top of it and converted the ppc code
to use the power-off handler.

I'll just resubmit the entire series in a day or two. Can't wait forever.

Guenter
