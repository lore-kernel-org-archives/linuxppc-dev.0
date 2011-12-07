Return-Path: <wg@grandegger.com>
Received: from ngcobalt02.manitu.net (ngcobalt02.manitu.net [217.11.48.102])
 by ozlabs.org (Postfix) with ESMTP id 1E3611007D2
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Dec 2011 19:50:38 +1100 (EST)
Message-ID: <4EDF22DF.5020001@grandegger.com>
Date: Wed, 07 Dec 2011 09:25:03 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH net-next v6 4/4] powerpc: tqm8548/tqm8xx: add and update
 CAN device nodes
References: <1322732481-2255-1-git-send-email-wg@grandegger.com>	
 <1322732481-2255-5-git-send-email-wg@grandegger.com>
 <1323243268.660.71.camel@pasglop>
In-Reply-To: <1323243268.660.71.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
 devicetree-discuss@lists.ozlabs.org, socketcan-users@lists.berlios.de,
 linux-can@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/07/2011 08:34 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2011-12-01 at 10:41 +0100, Wolfgang Grandegger wrote:
>> This patch enables or updates support for the CC770 and AN82527
>> CAN controller on the TQM8548 and TQM8xx boards.
> 
> I'm a bit confused by the net-next prefix here. Those patches seem to
> be only touching arch/powerpc and seem to be sent primarily toward
> netdev with a net-next prefix.

These patches are part of a series implementing a new netdev CAN driver
with device-tree support for CC770/i82527 CAN controllers. The
device-tree support and bindings are properly documented and some DTS
files have been updated accordingly. The relevant maintainers and
mailing list have been addressed.

> Also there have been at least 3 versions in a couple of days already
> without comments nor indication of what was changed...

Unfortunately, no response from those sub-system guys.

> Can you clarify things a bit please ? It looks like they really should
> go to linuxppc-dev (and you can probably drop a bunch of other lists) or
> am I missing an important piece of the puzzle ? (Such as patch 1/4 and
> 2/4 ...)

I have not sent the  whole series. The changes are documented in the
cover-letter, which I have not sent for those patches. Well, I think
it's better to sent the whole series to all parties instead?

> Let me know if I should just remove them from powerpc patchwork.

Dave has already applied all patches.

Sorry for the confusion. Any advice on how to handle multi subsystem
series of patches properly is welcome.

Wolfgang.
