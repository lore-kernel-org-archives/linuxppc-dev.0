Message-ID: <38BB3177.822E5778@chpc.utah.edu>
Date: Mon, 28 Feb 2000 19:39:51 -0700
From: Lou Langholtz <ldl@chpc.utah.edu>
MIME-Version: 1.0
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: problem building 2.3.47: no macintosh.a file
References: <Pine.LNX.3.96L.1000228205949.7447A-100000@unix48.andrew.cmu.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hollis R Blanchard wrote:

> On Mon, 28 Feb 2000, Lou Langholtz wrote:
>
> > When trying to compile the 2.3.47 linux distribution from a kernel.org
> > mirror, I don't get a macintosh.a file built in my drivers/macintosh/
> > directory. As a matter of fact, I don't seem to get any macintosh
> > drivers built in that directory as there's no .o files at all. Anyone
> > else experience this? I've tried poking around to discover where the
> > error could be but so far I'm clueless about this. Am I doing something
> > wrong with my .config configuration info? I've attached my .config file
> > in case this could be it and someone could check it. Any other
> > possibilities?
>
> I would recommend not using kernel.org sources for a while. Paul's tree seems
> to be the favorite for Macs right now.
>
> -Hollis

Thanks for responding so quickly. I feel so close now to actually getting the
2.3.47 sources to fully link. I'm down to just a multiple definitions error. Do
you suspect I'll still have lots of trouble with the 2.3.47 sources if I get
them to build on my PowerMac 7500? I know in the past that Paul stuff has been
infinitely better for PowerMacs while the kernel.org code simply wouldn't even
run. I'm hoping though that for a simple long time supported PowerMac 7500 that
the 2.3.47 sources should at least work better than my current 2.2.13pre15
kernel. Specifically I want to see that the darn ppp kernel freeze bug has gone
away since I use PPP so critically.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
