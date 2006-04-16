Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7F732679F8
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Apr 2006 06:43:12 +1000 (EST)
Subject: Re: PowerBook5,4 -- no sound?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Collins <paul@briny.ondioline.org>
In-Reply-To: <878xq51t61.fsf@briny.internal.ondioline.org>
References: <878xq51t61.fsf@briny.internal.ondioline.org>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 06:43:03 +1000
Message-Id: <1145220183.9833.9.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-04-17 at 00:39 +1000, Paul Collins wrote:
> With Linus's current git plus the boot fix and some unrelated patches
> (console font and bluetooth) sound no longer seems to work (nothing in
> /proc/asound/cards), although snd-powermac loaded without complaint.
> Is this a known problem?

Load i2c-powermac before snd-powermac

Ben.
