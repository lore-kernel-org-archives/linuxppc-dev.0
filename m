Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0C73B2C00F2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 10:49:28 +1000 (EST)
Message-ID: <1376959755.25016.107.camel@pasglop>
Subject: Re: Pull request: scottwood/linux.git next
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@gmail.com>
Date: Tue, 20 Aug 2013 10:49:15 +1000
In-Reply-To: <CA+5PVA49T3gWCb-tt83iabNPwB7=xA8qLw3CY06z4mpZHjj7OA@mail.gmail.com>
References: <20130808224501.GA8925@home.buserror.net>
 <1376453881.4255.57.camel@pasglop>
 <1376499759.31636.15.camel@snotra.buserror.net>
 <1376514060.4255.73.camel@pasglop>
 <1376952992.31636.382.camel@snotra.buserror.net>
 <1376956039.25016.103.camel@pasglop>
 <CA+5PVA49T3gWCb-tt83iabNPwB7=xA8qLw3CY06z4mpZHjj7OA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-08-19 at 19:49 -0400, Josh Boyer wrote:
> > I think mfspr works everywhere we care about but I might be mistaken :-)
> > I don't think anybody have tried booting a 403 in a looooong time. I
> > would be surprised if it still worked.
> 
> I think I have one buried somewhere in my garage.  I'm not digging it out.

Don't :-)

I'm thinking of removing the code... been wanting to do that for a while,
I'd be surprised if it still worked anyway. How much RAM do these things
have ? Probably not enough for a recent kernel...

Cheers,
Ben.
