Subject: Re: Zilog driver - auto-detect for no oopsen
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Eger <eger@theboonies.us>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.58.0403251503060.7074@rosencrantz.theboonies.us>
References: <Pine.LNX.4.58.0403251503060.7074@rosencrantz.theboonies.us>
Content-Type: text/plain
Message-Id: <1080253175.1218.14.camel@gaston>
Mime-Version: 1.0
Date: Fri, 26 Mar 2004 09:19:35 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2004-03-26 at 01:12, David Eger wrote:
> I recently compiled  Linux Kernel v2.6.5-rc2-ben0 and...
>
> Is there any auto-detection code we can add to the Zilog driver?
>
> I accidentally enabled the  CONFIG_SERIAL_PMACZILOG option for my kernel,
> and it crashes my powerbook all to hell when i try to put it to sleep...
> I know the option is irrelevant for my hardware, but is Oops'ing really
> what we want as a bad .config reminder?

Hrm... that was supposed to be fixed. It definitely doesn't crash here
(the crash I fixed recently is on wakeup btw, not sleep).

I'd appreciate some debugging to figure out what exactly is going
on. It seems it accessing a wrong pointer but I fail to see what
precisely

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
