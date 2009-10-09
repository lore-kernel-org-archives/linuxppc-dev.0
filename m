Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 95E5DB70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Oct 2009 17:27:29 +1100 (EST)
Subject: Re: [PATCH/RFC] powerpc: Fix decrementer setup on 1GHz boards
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200910090728.28870.sr@denx.de>
References: <1255013362-27135-1-git-send-email-sr@denx.de>
	<1255032776.2146.7.camel@pasglop>  <200910090728.28870.sr@denx.de>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 09 Oct 2009 17:27:15 +1100
Message-Id: <1255069635.2861.0.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-10-09 at 07:28 +0200, Stefan Roese wrote:
> 
> So how could we solve this issue now? Apply my current patch? Any
> other suggestions? 

Well, we probably need your current patch, but I'm not 100% it's enough.
We need to check for example that the vDSO code for 32-bit isn't going
to go out of bounds neither.

Cheers,
Ben.
