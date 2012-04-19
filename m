Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zoneX.GCU-Squad.org [194.213.125.0])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 32BA6B6FF5
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 21:02:27 +1000 (EST)
Date: Thu, 19 Apr 2012 13:02:11 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 00/15] PowerMac i2c API conversions & windfarm updates
Message-ID: <20120419130211.134e3c1d@endymion.delvare>
In-Reply-To: <m27gxc2fqq.fsf@igel.home>
References: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
 <20120419113723.03a24d46__2279.25503063506$1334829915$gmane$org@endymion.delvare>
 <m27gxc2fqq.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Christian Kujau <lists@nerdbynature.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hallo Andreas,

On Thu, 19 Apr 2012 12:11:25 +0200, Andreas Schwab wrote:
> Jean Delvare <khali@linux-fr.org> writes:
> 
> > These drivers were the last ones blocking the removal of the legacy
> > binding model in i2c-core.
> 
> There are also still some uses in snd-aoa.

You're right, there are still 3 sound drivers which need to be
converted (aoa/onyx, aoa/tas and ppc/keywest.) I believe Benjamin will
take care of the latter when he is done with the thermal management
drivers. Not sure who can work on and/or test the aoa sound drivers.

-- 
Jean Delvare
