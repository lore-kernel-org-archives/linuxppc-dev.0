Message-ID: <3932D946.2E0955C3@pop.agri.ch>
Date: Mon, 29 May 2000 22:55:35 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: mlan@cpu.lu
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Serial console in 2.3.99?
References: <200005271046.MAA00581@piglet.grunz.lu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:
>
> Hi all,
>
> I don't seem to get the serial console working in Paul's 2.3.99-pre9. I
> have tried all kernel command lines, but no dice.... I had it working in
> 2.2.15, but that same command line does not work for 2.3.99. The cabling
> is ok; I can cat files out the serial ports and get them on the other
> side. But not a single character of kernel log shows up...
>
> Anybody know what's happening? Any patches around? I absolutely need the
> console to debug strange crashes, with nothing in the syslog...

Well, not that helpful but here are my experiences:
Today rsynced 2.3.99p9 from linuxcare->

vector: 700 at pc = c000673c, lr = c00051f8, msr = 81030, sp = c01f2ee0 [c01f2e30]
current = c01f1000, pid = 0, comm = swapper
mon> x

This is on a pm7200, the same with bitkeeper. So the line must be working(physical).

Tomorrow I try to get a bk tree with the changes visible, but 300MB in size.....
No, not today via 56k modem....

A 2.3.99p6 DID work under 7200. I suppose digging in the diffs is now
THE task, for me, if it boots, then I/we have to find out about the
console stuff.
In other words, I'm also interested in getting this to work.

regards
Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
