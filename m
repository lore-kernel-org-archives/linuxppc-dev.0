Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 466FE1A2B0D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 14:50:04 +1100 (AEDT)
In-Reply-To: <1427080598.4770.214.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc dev list <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: drivers/of: Add empty ranges quirk for PA-Semi
Message-Id: <20150323035004.2D6B9140134@ozlabs.org>
Date: Mon, 23 Mar 2015 14:50:04 +1100 (AEDT)
Cc: Olof Johansson <olof@lixom.net>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Rob Herring <robherring2@gmail.com>, Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-23-03 at 03:16:38 UTC, Benjamin Herrenschmidt wrote:
> The "sdc" node is missing the ranges property, it needs to be treated
> as having an empty one otherwise translation fails for its children.
> 
> Tested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Fixes: 746c9e9f92dd ("of/base: Fix PowerPC address parsing hack")

Which went into 3.18-rc6, and was CC'ed to stable. So this should probably also
go to stable no?

cheers
