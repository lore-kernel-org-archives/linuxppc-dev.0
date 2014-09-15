Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7277B1A0121
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 22:25:04 +1000 (EST)
Message-ID: <1410783892.31754.88.camel@pasglop>
Subject: Re: [PATCH 1/4] powerpc/powernv: Add OPAL check token call
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 15 Sep 2014 08:24:52 -0400
In-Reply-To: <1410750623.24738.9.camel@concordia>
References: <1408423682-14297-1-git-send-email-mikey@neuling.org>
 <1410750623.24738.9.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-09-15 at 13:10 +1000, Michael Ellerman wrote:
> > +enum OpalCheckTokenStatus {
> > +       OPAL_TOKEN_ABSENT = 0,
> > +       OPAL_TOKEN_PRESENT = 1
> > +};
> 
> I don't see this used anywhere?
> 
> And NoCamelCase !
> 
> Yes I know there's lots in that file, but I didn't merge that :)

The original OPAL APIs were like that and I chose to not "fix" them
because I've been aiming at reconciling the Linux and the FW versions
of the file, which I haven't had a chance to do yet (Cyril & Sam have
some WIP in that area afaik).

We could de-camelify them both but I'd rather do the reunification
first.

Cheers,
Ben.
