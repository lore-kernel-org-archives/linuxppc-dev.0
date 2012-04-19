Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 59627B7004
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2012 07:00:03 +1000 (EST)
Message-ID: <1334869188.3143.29.camel@pasglop>
Subject: Re: [PATCH 00/15] PowerMac i2c API conversions & windfarm updates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jean Delvare <khali@linux-fr.org>
Date: Fri, 20 Apr 2012 06:59:48 +1000
In-Reply-To: <20120419113723.03a24d46@endymion.delvare>
References: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
 <20120419113723.03a24d46@endymion.delvare>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Christian Kujau <lists@nerdbynature.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-04-19 at 11:37 +0200, Jean Delvare wrote:

> Benjamin, thanks a lot for doing this! These drivers were the last ones
> blocking the removal of the legacy binding model in i2c-core.

There's a couple left :-) I haven't done therm_windtunnel.c (here too, I
need testers when I'm done) and our sound drivers are still using the
old API afaik, that's next on my list.

>  Testers
> are very welcome. The earliest we can get these changes upstream, the
> better.
> 
> Christian, can you please test this series? I'm sure Benjamin can send
> the patches to you directly if needed.

The main problem is that I don't have a Xserve G5 anymore to test,
that's one driver that largely rewritten and totally untested...

Cheers,
Ben.
