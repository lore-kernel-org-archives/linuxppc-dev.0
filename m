Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9D4972C01C2
 for <linuxppc-dev@ozlabs.org>; Sun,  1 Jul 2012 21:15:01 +1000 (EST)
Message-ID: <1341141293.2588.1.camel@pasglop>
Subject: Re: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
Date: Sun, 01 Jul 2012 21:14:53 +1000
In-Reply-To: <21923.1341139814@neuling.org>
References: <1341002709.2563.28.camel@pasglop> <21923.1341139814@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2012-07-01 at 20:50 +1000, Michael Neuling wrote:
> > Here are a few powerpc fixes. Arguably some of this should have come to
> > you earlier but I'm only just catching up after my medical leave.
> > 
> > Mostly these fixes regressions, a couple are long standing bugs.
> 
> Benh,
> 
> This should probably go up now too:
> 
>   http://patchwork.ozlabs.org/patch/167270/
> 
> Do you want me to send it separate from that series?

Looks like it needs to go to -stable all the way down to 3.2... I'll
send it tomorrow with the appropriate tags.

Cheers,
Ben.
