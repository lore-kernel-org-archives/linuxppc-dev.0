Date: Thu, 10 Aug 2000 09:44:28 +0300 (EET DST)
From: Topi Kanerva <tkanerva@ees2.oulu.fi>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Derek Homeier <supas100@astrophysik.uni-kiel.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Backlight control on Lombard PB
In-Reply-To: <Pine.LNX.4.10.10008090004530.22030-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.GSO.4.21.0008100940040.28327-100000@stekt6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 9 Aug 2000, Michael Schmitz wrote:

>Should be fixed in BenH's current tree, he said he was going to do it this
>past weekend. The pmu backlight controller didn't get registered on the
>Lombard (and possibly Wallstreet) because the backlight-control property
>is missing on these machines.

Well, the backlight control surely doesn't work on Pismos... I just hate
it when I have to boot over to MacOS to switch up the backlight level
(I usually keep it low because it eats so much battery...)
Now, I realize that the PMU on Pismos is somewhat different, but supposedly
there is a way (in MacOS) to try to poke what kind of values are being
written to the registers when you change the backlight in MacOS (fn-F1/F2)

actually, to be able to turn off the backlight is perharps the most
important single power-saving feature. unfortunately, I myself don't have
any reverse-engineering experience on MacOS (this is my first mac ever...)


-topi


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
