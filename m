Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6E7BC1A0681
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 03:15:47 +1100 (AEDT)
Received: by pdnc3 with SMTP id c3so33171858pdn.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 09:15:44 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: drivers/of: Add empty ranges quirk for PA-Semi
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman
 <mpe@ellerman.id.au>
In-Reply-To: <1427083595.4770.221.camel@kernel.crashing.org>
References: <20150323035004.2D6B9140134@ozlabs.org>
 <1427083595.4770.221.camel@kernel.crashing.org>
Date: Wed, 25 Mar 2015 09:15:43 -0700
Message-Id: <20150325161543.27663C408FE@trevor.secretlab.ca>
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

On Mon, 23 Mar 2015 15:06:35 +1100
, Benjamin Herrenschmidt <benh@kernel.crashing.org>
 wrote:
> On Mon, 2015-03-23 at 14:50 +1100, Michael Ellerman wrote:
> > On Mon, 2015-23-03 at 03:16:38 UTC, Benjamin Herrenschmidt wrote:
> > > The "sdc" node is missing the ranges property, it needs to be treated
> > > as having an empty one otherwise translation fails for its children.
> > > 
> > > Tested-by: Steven Rostedt <rostedt@goodmis.org>
> > > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> > Fixes: 746c9e9f92dd ("of/base: Fix PowerPC address parsing hack")
> > 
> > Which went into 3.18-rc6, and was CC'ed to stable. So this should probably also
> > go to stable no?
> 
> Sure, go for it.

Applied, thanks.

g.
