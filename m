Return-Path: <m.kozlowski@tuxland.pl>
Received: from tuxland.pl (xdsl-664.zgora.dialog.net.pl [81.168.226.152])
	by ozlabs.org (Postfix) with ESMTP id 714DADDF23
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 10:55:45 +1100 (EST)
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] ppc: vio of_node_put cleanup
Date: Wed, 3 Jan 2007 00:57:08 +0100
References: <200701021238.36297.m.kozlowski@tuxland.pl>
	<1220f3e52f791ff8871ca9328b027a5a@kernel.crashing.org>
In-Reply-To: <1220f3e52f791ff8871ca9328b027a5a@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701030057.08957.m.kozlowski@tuxland.pl>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Segher, 

> The comment used to be inside the "if" block, is this
> change correct?

You'd prefer an empty line in there?

> [And, do we want all these changes anyway?  I don't care
> either way, both sides have their pros and their cons --
> just asking :-) ]

You know my opinion already :-)

-- 
Regards,

	Mariusz Kozlowski
