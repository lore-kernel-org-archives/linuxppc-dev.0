Date: Wed, 25 Oct 2000 02:36:42 +1100
From: Chris Leishman <masklin@debian.org>
To: Rob <capveg@cs.umd.edu>
Cc: Chris Leishman <masklin@debian.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: airport woes?
Message-ID: <20001025023642.B2505@nina.dev.fol>
References: <20001024151644.A660@nina.dev.fol> <200010241533.LAA04867@xor.cs.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200010241533.LAA04867@xor.cs.umd.edu>; from capveg@cs.umd.edu on Tue, Oct 24, 2000 at 11:33:46AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Oct 24, 2000 at 11:33:46AM -0400, Rob wrote:
>
> >I'm using benh's latest kernel and airport driver.  Now I can't think what
> >would be causing this, but I thought you'd like to know.  Anyone else seen
> >this problem?
>
> I have the above (with the patched pcmcia package), bronze lombard 400mhz, and
> everything works for me.  It honestly sounds like a lack of signal problem.
> There are a couple of graphical signal strength monitors, or you could do what
> I did, and write a stupid shell script (ask me if you want it) to dredge the
> signal strength out of /proc.
>


I don't think its signal strength, since I'm almost sitting on top of the base
station 90% of the time - and it doesn't seem to affect data coming back to
me.

Also, I've got a pismo - with the built in "apple branded" airport card, and
I'm using BenH's airport driver (not the pcmcia one).  Ben mailed me earlier
to say he is working on something...

Thanks,

Chris

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
