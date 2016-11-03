Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8WL047J4zDt0c
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 14:54:00 +1100 (AEDT)
Message-ID: <1478145230.6502.3.camel@kernel.crashing.org>
Subject: Re: [PATCH] Fix loading of module radeonfb on PowerMac
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mathieu Malaterre <malat@debian.org>, Tomi Valkeinen
 <tomi.valkeinen@ti.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Lennart
 Sorensen <lsorense@csclub.uwaterloo.ca>, Jean-Christophe Plagniol-Villard
 <plagnioj@jcrosoft.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 02 Nov 2016 21:53:50 -0600
In-Reply-To: <CA+7wUsy9AW6BvNd=Bmmwra-YfTMAqFwLMg7Z7ZNXpxORq9qtTg@mail.gmail.com>
References: <1475928540-19647-1-git-send-email-malat@debian.org>
 <fbf3b5a3-efd9-0f85-c4fe-ae34ae1862b7@ti.com>
 <CA+7wUsy9AW6BvNd=Bmmwra-YfTMAqFwLMg7Z7ZNXpxORq9qtTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-11-02 at 11:28 +0100, Mathieu Malaterre wrote:
> 
> This has been working great so far for `radeon.ko`, so I assumed I
> could shamelessly copy the behavior over to `radeonfb.ko`.
> 
> The original reference I found was from Benjamin Herrenschmidt here:
> https://lists.freedesktop.org/archives/dri-devel/2010-August/002907.h
> tml
> 
> I am of course willing to try something else, but I would need some
> guidance.

I missed your original patch but yes, the basic idea is that we kick
out offb when the "real" driver loads.

Cheers,
Ben.
