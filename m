Message-ID: <3A59CF72.750A6C1A@pop.agri.ch>
Date: Mon, 08 Jan 2001 15:32:29 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Conrad H Ziesler <cziesler@umich.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: ibook, hda power off sequence (for IBM travelstar)
References: <Pine.SOL.4.10.10101061727190.28634-100000@frogger.gpcc.itd.umich.edu> <19341203045809.13248@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,


Benjamin Herrenschmidt wrote:
>
> >
> >This bit of code replaces pmu_shutdown from via-pmu.c, its the easiest
> >hack to get the IDE code to issue a sleep command to the disk at shutdown
> >time.
>
> Broadcasting fake sleep requests is definitely not the correct way to
> acheive what you want. Either add direct call to some ide-pmac sleep
> function in the arch shutdown function, or use the shutdown notifiers in
> ide-pmac to force a disk shutdown.
>
> I'll have a look at it when I'm really back.

I'm also interested in this fix since I got my travelstar DJSA-220
finally to work on a WALLSTREET! I remarked the same noisy click and
since the troubles I had with a dead toshiba I pay very much attention
to strange noises.

For those who have a wallstreet and a travelstar, here the link which
made my combination work.

http://www.xlr8yourmac.com/PB_G3/wallstreet_hard_drive/

I first thought I really have to buy a new Powerbook.

Only a notice, it may help some one.....

Cheers

Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
