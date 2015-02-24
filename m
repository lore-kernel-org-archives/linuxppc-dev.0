Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44B471A0006
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 08:11:59 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8868314008F
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2015 08:11:58 +1100 (AEDT)
Message-ID: <1424812311.12891.51.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Export __spin_yield
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Suresh E. Warrier" <warrier@linux.vnet.ibm.com>
Date: Wed, 25 Feb 2015 08:11:51 +1100
In-Reply-To: <54ECA8DB.9000707@linux.vnet.ibm.com>
References: <1424477465-9199-2-git-send-email-warrier@linux.vnet.ibm.com>
 <54EBC165.3020708@linux.vnet.ibm.com>
 <1424749119.12891.20.camel@kernel.crashing.org>
 <54ECA8DB.9000707@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-02-24 at 10:37 -0600, Suresh E. Warrier wrote:
> On 02/23/2015 09:38 PM, Benjamin Herrenschmidt wrote:
> > On Mon, 2015-02-23 at 18:10 -0600, Suresh E. Warrier wrote:
> >> Export __spin_yield so that the arch_spin_unlock() function
> >> can be invoked from a module.
> > 
> > Make it EXPORT_SYMBOL_GPL. Also explain why a module might need it
> > 
> 
> Sure, I will change that to EXPORT_SYMBOL_GPL. Just curious, though, 
> there is another symbol arch_spin_unlock_wait that is exported from
> the file without the _GPL prefix. Any idea why?

Nope. Not sure how come we did that.

> I have mentioned that this needs to be exported to call the 
> arch_spin_unlock() function from a module. What additional information
> do you think will be useful here ? Are you looking at something
> that explains why a module might need to call arch_spin_unlock()?

What kind of module might need it...

Cheers,
Ben.
