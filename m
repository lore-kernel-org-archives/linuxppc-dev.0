Return-Path: <paul@briny.ondioline.org>
Received: from jenny.ondioline.org (jenny.ondioline.org [66.220.1.122])
	by ozlabs.org (Postfix) with ESMTP id A112067B23
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Apr 2006 10:37:26 +1000 (EST)
From: Paul Collins <paul@briny.ondioline.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PowerBook5,4 -- no sound?
References: <878xq51t61.fsf@briny.internal.ondioline.org>
	<1145220183.9833.9.camel@localhost.localdomain>
Date: Mon, 17 Apr 2006 10:34:32 +1000
In-Reply-To: <1145220183.9833.9.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Mon, 17 Apr 2006 06:43:03 +1000")
Message-ID: <874q0t11lz.fsf@briny.internal.ondioline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Mon, 2006-04-17 at 00:39 +1000, Paul Collins wrote:
>> With Linus's current git plus the boot fix and some unrelated patches
>> (console font and bluetooth) sound no longer seems to work (nothing in
>> /proc/asound/cards), although snd-powermac loaded without complaint.
>> Is this a known problem?
>
> Load i2c-powermac before snd-powermac

Like Andreas, I have =y and =m for those.

-- 
Dag vijandelijk luchtschip de huismeester is dood
