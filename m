Date: Wed, 9 Aug 2000 19:22:10 +0200 (MET DST)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Backlight control on Lombard PB
In-Reply-To: <Pine.LNX.4.10.10008090004530.22030-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.SOL.3.95.1000809191056.5966B-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 9 Aug 2000, Michael Schmitz wrote:

> > I saw a couple of posts from people who seem to have the recent kernels
> > (2.2.17pre1[3-5]-ben1) running on a 1999 Powerbook.
> > Unfortunately, I have still the same problems with the backlight control
> > that first appeared with 2.2.17pre10-ben1, i.e.
> >
> >  1. {Fn-,}F[12] don't adjust brightness
> >  2. After wakeup from sleep, the backlight remains dark
>
> Should be fixed in BenH's current tree, he said he was going to do it this
> past weekend. The pmu backlight controller didn't get registered on the
> Lombard (and possibly Wallstreet) because the backlight-control property
> is missing on these machines.
>
So we were just lucky that it used to work before?

It should be in the linux-pmac-benh branch then, yeah? I rsynced again
from linuxcare.com.au yesterday (or rather 2:00 UT this morning), and the
problem still remains. Is there anything else to do, upgrade to a newer
BootX perhaps, or whatever?

Thanks,
							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
