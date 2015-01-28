Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E6091A08B0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 07:15:46 +1100 (AEDT)
Date: Wed, 28 Jan 2015 14:15:33 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2] powerpc/mpic: Add DT option to skip readback after EOI
Message-ID: <20150128201533.GA10436@gate.crashing.org>
References: <1422371952-1126-1-git-send-email-bogdan.purcareata@freescale.com>
 <1422395873.10544.61.camel@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422395873.10544.61.camel@freescale.com>
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

On Tue, Jan 27, 2015 at 03:57:53PM -0600, Scott Wood wrote:
> At this point, given the previous discussion, does anyone object to
> removing the readback entirely?  Do we have any evidence that reading
> WHOAMI is effective at addressing whatever problem reading EOI made go
> away on the relevant platform?

What platforms were those?  Just test there!

If no one remembers, they can not (any longer) be important platforms ;-)
Just remove the code, and if in twelve months finally someone reports a
failure we will at least know what platform it was.


Segher
