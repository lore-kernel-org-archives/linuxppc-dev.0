Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B947E1007F5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 16:29:11 +1100 (EST)
Subject: Re: [RFC PATCH 02/19] powerpc: gamecube: device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40911252038y37da8c72y54314a6cc337fc66@mail.gmail.com>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221502g2de254d2o4341d9abed0cdf41@mail.gmail.com>
	<1259209283.16367.241.camel@pasglop>
	<fa686aa40911252038y37da8c72y54314a6cc337fc66@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 26 Nov 2009 16:29:05 +1100
Message-ID: <1259213345.16367.275.camel@pasglop>
Mime-Version: 1.0
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-11-25 at 21:38 -0700, Grant Likely wrote:
> 
> But this isn't real OF.  Real OF can generate its own valid tree.
> This is a flat tree, and it is valid according to all users of the
> flat tree.  Besides, the last time we talked about this, you told me
> that moving it to the root was a good idea, and I happily changed all
> the 5200 .dts files.  :-)
> 
> http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-January/067046.html

Oh sure. I wasn't sure what the situation vs. real OF was. I just know
Segher is doing one and it would be nice to have the closest tree :-)

But no big deal, I'm happy with it at the root. I prefer not ommiting it
completely tho.

Cheers,
Ben.
