Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D46FF1007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Sep 2011 05:41:42 +1000 (EST)
Message-ID: <4E7A3DED.9030402@freescale.com>
Date: Wed, 21 Sep 2011 14:41:33 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Vineeth <vneethv@gmail.com>
Subject: Re: Timer interrupt on Linux 3.0.3
References: <CAFbQSaD-c=QqSsq__VtBEcMCJabnBi4AP4KunDNV7u7xXAuaTw@mail.gmail.com>
	<4E73816C.6000304@freescale.com>
	<CAFbQSaBcdLCoVY471mVLAyM=eYDSN77=DODPasMaAEm6pRm7jQ@mail.gmail.com>
In-Reply-To: <CAFbQSaBcdLCoVY471mVLAyM=eYDSN77=DODPasMaAEm6pRm7jQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org, linux-embedded@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/21/2011 01:56 AM, Vineeth wrote:
>>> What was the issue?  You really should try to make this work rather than
>>> hack around it.
> 
> what we found was the decrementer is not generating an exception when it
> becomes 0. and the timebase registers are not getting incremented too.

Does the decrementer actually tick until it reaches zero, or do it and
the timebase never tick?

Is the TBEN input to the CPU asserted?

-Scott
