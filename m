Date: Mon, 13 Aug 2001 21:59:05 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org, paulus@samba.org
Subject: Re: Occasional crash reports
In-Reply-To: <20010813163521.17302@smtp.adsl.oleane.com>
Message-ID: <Pine.A41.3.96LJ1.1b7.1010813214052.84970D-100000@unlserve.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 13 Aug 2001, Benjamin Herrenschmidt wrote:

> I'm getting regular crash reports for which I'm having trouble figuring
> out what's going on exactly. Those are with my tree or bk 2_4_devel, but
> the problem may be present elsewhere.
>
> So basically, the kernel tends to die in various locations where things
> should be just fine, but I did notice one thing: In most of these cases,
> I had softirq around in the backtrace (either running in softirqs, or
> having do_softirq() in the backtrace). There is one case where I didn't
> have it: it dies inside power_save(), so probably because an interrupt
> that happened just before messed things up.
>
> I'm wondering if we might be running into some stack overflow...

I don't really know, but I can confirm that both 2.2.x and 2.4.x kernels
are unstable on a beige g3 and a bmac equipped b/w g3.  I can crash them
rather easily with regular programs, given a day or two.  I have not seen
similar instability on other machines (dual g4, 7600, all nubus).
Unfortunately, I don't have any time to track it down right now  :(


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
