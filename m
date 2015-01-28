Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0140.outbound.protection.outlook.com [157.56.110.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9F3EA1A0A40
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 10:03:43 +1100 (AEDT)
Message-ID: <1422486205.10544.99.camel@freescale.com>
Subject: Re: [PATCH v2] powerpc/mpic: Add DT option to skip readback after EOI
From: Scott Wood <scottwood@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Date: Wed, 28 Jan 2015 17:03:25 -0600
In-Reply-To: <20150128201533.GA10436@gate.crashing.org>
References: <1422371952-1126-1-git-send-email-bogdan.purcareata@freescale.com>
 <1422395873.10544.61.camel@freescale.com>
 <20150128201533.GA10436@gate.crashing.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org,
 Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-01-28 at 14:15 -0600, Segher Boessenkool wrote:
> On Tue, Jan 27, 2015 at 03:57:53PM -0600, Scott Wood wrote:
> > At this point, given the previous discussion, does anyone object to
> > removing the readback entirely?  Do we have any evidence that reading
> > WHOAMI is effective at addressing whatever problem reading EOI made go
> > away on the relevant platform?
> 
> What platforms were those?  Just test there!

Ben said "some macs".  The only Mac I have is packed away and may not be
the one Ben had in mind, so I can't "test there".

> If no one remembers, they can not (any longer) be important platforms ;-)
> Just remove the code, and if in twelve months finally someone reports a
> failure we will at least know what platform it was.

This is what I was trying to encourage. :-)

-Scott
