Return-Path: <sneakums@zork.net>
Received: from zork.zork.net (zork.zork.net [64.81.246.102])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 630702BDB5
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Nov 2004 10:01:13 +1100 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <6ubrdsjiq1.fsf@zork.zork.net> <1100989339.3795.6.camel@gaston>
	<6u7jogjg8t.fsf@zork.zork.net> <1100991146.3795.17.camel@gaston>
From: Sean Neakums <sneakums@zork.net>
Date: Sat, 20 Nov 2004 23:01:08 +0000
In-Reply-To: <1100991146.3795.17.camel@gaston> (Benjamin Herrenschmidt's
	message of "Sun, 21 Nov 2004 09:52:26 +1100")
Message-ID: <6uy8gwi0qz.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: TEST: Sleep suppport for iBook G4 & Aluminium PowerBooks (ATI
	based)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Sat, 2004-11-20 at 22:41 +0000, Sean Neakums wrote:
>
>> It was built modular but not loaded, and /dev/apm_bios was present.
>> Having exited X, loaded the module and restarted X, I tried
>> suspend/resume again.  It worked well as before, but the corruption is
>> still present.  In XFree86.0.log, I now see a "(II) Open APM
>> successful" instead of "(WW) Open APM failed (/dev/apm_bios) (No such
>> device) ", but nothing that seems to relate to suspend/resume events.
>> 
>> The corruption doesn't appear immediately; it starts as a light
>> specking of the image and progressively getting worse with subsequent
>> redisplayings.
>
> No idea at this point. It doesn't happen on the albooks I could test
> with here... Can you send me a snapshot of a corrupted screen ?

Here is a (rather large) screen shot I took, showing the corrupted
root window image.

http://dasbistro.com/~sneakums/corruption.png

> Does it still happen if you disable dynamic clocks ?
> (radeonfb.default_dynclk=-1 on the kernel cmdline and Option
> "DynamicClocks" "false" in X if you are using X.org). And if you
> disable accel in X ? (Option "NoAccel" "true")

I'll try these out.
