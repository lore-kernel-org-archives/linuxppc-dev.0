From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	<linuxppc-dev@lists.linuxppc.org>, <debian-powerpc@lists.debian.org>
Subject: Re: Success! (was Re: External Monitor under Pismo)
Date: Fri, 4 May 2001 16:54:22 +0200
Message-Id: <20010504145422.25284@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.05.10105041612120.2886-100000@callisto.of.borg>
References: <Pine.LNX.4.05.10105041612120.2886-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>
>If you point the second CRTC to the same frame buffer region, you'll have
>mirrorring, else you have two different heads.

In most cases (like what I do with aty128fb), you don't even need to use the
second CRTC. Just enable both outputs and let them source from the first CRTC.

>> So i suppose the you will need to use a trick similar to the matrox one
>to get
>> dual headed accelerated X to work.
>
>Yep. The same is true for atyfb (yes, I should add mirrorring/dualhead
support
>for the Mobility in my Vaio :-).
>
>> But could it be possible to block this in hardware, and thus force
mirroring
>> only operation ?
>
>I suppose yes.
>
>> How many different rage 128 mobility are around anyway ?
>
>No idea. I just at the ATI website earlier today, and they seem to have new
>variants called M4 and Radeon Mobility.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
