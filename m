Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xnR930b2zDqj4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Aug 2018 02:53:24 +1000 (AEST)
Date: Fri, 24 Aug 2018 11:52:42 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Rob Herring <robh@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Kumar Gala <kumar.gala@linaro.org>, devicetree@vger.kernel.org,
 devicetree-spec@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Grant Likely <grant.likely@arm.com>, Frank Rowand <frowand.list@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: DT case sensitivity
Message-ID: <20180824165242.GW24439@gate.crashing.org>
References: <CAL_Jsq+XacT2O15CQ=F_6dmWf6OqNf8_fKAOrMJNR79a6mORaw@mail.gmail.com>
 <3335cff2cc999c1dda58d75949ab3d12185fca79.camel@kernel.crashing.org>
 <CAL_JsqKqkO31ekVMFKs+osLvKdZyDzRowF1thWXn5=tWhrJgvw@mail.gmail.com>
 <18175413a0148f7859ab36ed9715dce7a598f318.camel@kernel.crashing.org>
 <20180823123650.GT24439@gate.crashing.org>
 <CAL_Jsq+VnhT_4H4yECWsuXnmpQRnSHNRXAohRYds1LxcRjUHkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAL_Jsq+VnhT_4H4yECWsuXnmpQRnSHNRXAohRYds1LxcRjUHkw@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 24, 2018 at 10:14:01AM -0500, Rob Herring wrote:
> Another question: Is there ever a case where the node name in the path
> aka 'driver-name' doesn't match the 'name' property? I think this
> generally can't happen on FDT as the 'name' property is generated when
> we unflatten it though I suppose one could craft an FDT with name
> properties.

In Open Firmware, it *is* the "name" property :-)

> There's also various places in the kernel that check for a NULL name
> which doesn't seem like it could happen either other than the root
> node.

In Open Firmware the root node is required to have a "name" property, too.
There are systems that violate that rule (as with most rules...)


Segher
