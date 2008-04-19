Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 64FEFDDFDD
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Apr 2008 04:14:30 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so290218anc.78
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 11:14:28 -0700 (PDT)
Message-ID: <fa686aa40804191114i2cef26eegabfe9bc28d8ecc18@mail.gmail.com>
Date: Sat, 19 Apr 2008 12:14:28 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH] [PPC] Remove mpc8272 ads board from arch/ppc
In-Reply-To: <Pine.LNX.4.64.0804191051420.20132@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <Pine.LNX.4.64.0804191051420.20132@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 19, 2008 at 9:52 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
> We have a board port in arch/powerpc so we dont need this one anymore.
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Personally, I'd rather not do the piecemeal removal of board ports
from arch/ppc.  We've only got one release left anyway.  Removing them
just generates more churn and has the risk of causing other side
effects.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
