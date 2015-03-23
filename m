Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 780501A2C8E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 15:06:54 +1100 (AEDT)
Message-ID: <1427083595.4770.221.camel@kernel.crashing.org>
Subject: Re: drivers/of: Add empty ranges quirk for PA-Semi
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 23 Mar 2015 15:06:35 +1100
In-Reply-To: <20150323035004.2D6B9140134@ozlabs.org>
References: <20150323035004.2D6B9140134@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Rob Herring <robherring2@gmail.com>,
 linuxppc dev list <linuxppc-dev@lists.ozlabs.org>,
 Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-03-23 at 14:50 +1100, Michael Ellerman wrote:
> On Mon, 2015-23-03 at 03:16:38 UTC, Benjamin Herrenschmidt wrote:
> > The "sdc" node is missing the ranges property, it needs to be treated
> > as having an empty one otherwise translation fails for its children.
> > 
> > Tested-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Fixes: 746c9e9f92dd ("of/base: Fix PowerPC address parsing hack")
> 
> Which went into 3.18-rc6, and was CC'ed to stable. So this should probably also
> go to stable no?

Sure, go for it.

Cheers,
Ben.
