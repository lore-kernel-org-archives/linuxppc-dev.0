Return-Path: <andrew@lunn.ch>
Received: from vps0.lunn.ch (vps0.lunn.ch [178.209.37.122])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C3101A0807
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 02:29:41 +1100 (AEDT)
Date: Wed, 9 Dec 2015 16:29:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] sbc8641: drop bogus PHY IRQ entries from DTS file
Message-ID: <20151209152923.GL13328@lunn.ch>
References: <1449614642-8161-1-git-send-email-paul.gortmaker@windriver.com>
 <20151209030729.GA2093@lunn.ch>
 <20151209143951.GM22885@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151209143951.GM22885@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > Originally the interrupt is used for detecting the link has gone
> > down. That would of also been bogus before. Have you tried this?  If
> 
> Haven't tried it, but chances are you are right.
> 
> > that is also broken, maybe you need to add a fixes: tag so that it
> > gets back ported?
> 
> Nobody noticed in the past ~7 years or so, but I guess I can point Greg
> at it once it is present in mainline.  The main reason I'd Cc'd netdev
> is just to possibly save anyone else the investigation if they ran into
> the same issue on a different board -which seems highly probable IMHO.

Yes, you are probably right about other boards. So this change might
be considered as causing a regression. But if they are already broken,
because link down does not work, there might be less demand to get the
change reverted....

       Andrew
