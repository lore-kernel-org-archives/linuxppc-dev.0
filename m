Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 12D4EB7012
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2012 10:32:15 +1000 (EST)
Message-ID: <1336955527.6727.2.camel@pasglop>
Subject: Re: [PATCH v3 03/17] powerpc: Add PFO support to the VIO bus
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Robert Jennings <rcj@linux.vnet.ibm.com>
Date: Mon, 14 May 2012 10:32:07 +1000
In-Reply-To: <1336687098.3881.63.camel@pasglop>
References: <1334242825.18090.4.camel@key-ThinkPad-W510>
 <1334243302.18090.10.camel@key-ThinkPad-W510>
 <1335841603.3621.8.camel@pasglop>
 <20120510190835.GB12304@linux.vnet.ibm.com>
 <1336687098.3881.63.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Kent Yoder <key@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-05-11 at 07:58 +1000, Benjamin Herrenschmidt wrote:
> > 
> > Having the timeout and retries in this function is the wrong thing to do.
> > We'll resubmit this without the loop and the caller will be responsible for
> > retrying the operations.
> >
> > I would rather have the caller cede the processor or alter thread
> > priority where appropriate than doing that in this function.  I don't
> > think this should be done in this crypto driver.
> 
> That sounds right indeed... as long as the upper crypto layer has a
> concept of "try again later"... if it doesn't it will result in random
> funny failures :-)

Ping ?

So I'm merging 1 to 5 (ie, up to and including the hwrng driver). I will
still merge the rest if you send a fix for that in the next day or so
but not much longer.

Cheers,
Ben.
