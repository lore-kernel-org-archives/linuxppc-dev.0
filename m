Date: Tue, 31 Dec 2002 03:38:23 +0100
From: Peter Vandenabeele <peter.vandenabeele@mind.be>
To: Jerry Walden <jwalden@digitalatlantic.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: BDI2000 and 405GPr
Message-ID: <20021231033823.J5650@mind.be>
Reply-To: Peter Vandenabeele <peter.vandenabeele@mind.be>
References: <EGEGIJHKDKJGAJMGIDPNMEHDCDAA.jwalden@digitalatlantic.com> <EGEGIJHKDKJGAJMGIDPNEEJECDAA.jwalden@digitalatlantic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EGEGIJHKDKJGAJMGIDPNEEJECDAA.jwalden@digitalatlantic.com>; from jwalden@digitalatlantic.com on Mon, Dec 30, 2002 at 08:21:53PM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Dec 30, 2002 at 08:21:53PM -0800, Jerry Walden wrote:
>
> Hello:
>
> I just got my re-spun 405GPr based SBC from our board manufacturer.
>
> I'm not certain if this is the proper place to ask this question, if not
> perhaps you can direct me to another source.

Well, if you ask support to Abatron through your local supplier, they will
typically give very good support.

> I just purchased the latest and greated BDI2000, and when I telnet to
> the emulator I get the following over and over....
>
>
> BDI>
> - TARGET: processing user reset request
> *** TARGET: reseting target failed
> # JTAG: Communication test failed
> - TARGET: target will be restarted in 10 sec
>
> BDI>
> - TARGET: processing user reset request
> *** TARGET: reseting target failed
> # JTAG: Communication test failed
> - TARGET: target will be restarted in 10 sec

It is normal behavior for the BDI 2000 to try again after a
failed set-up every 10 seconds.

How is your reset exactly connected (electrically). You have
2 reset lines (one CPU RESET and one general RESET). They
are triggered in a specific order by the BDI for the 405GP.
Are they connected correctly to the logic of your board ?

Are there any reset chips that prolongue the global reset ?
(I believe the max time in the standard version should be
not more than 500 msec).

Do you see any signal on TDO ?

Peter

>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
