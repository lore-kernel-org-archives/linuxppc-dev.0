Date: Wed, 9 Aug 2000 00:08:03 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Derek Homeier <supas100@astrophysik.uni-kiel.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Backlight control on Lombard PB
In-Reply-To: <Pine.SOL.3.95.1000808191003.1384C-100000@juliet>
Message-ID: <Pine.LNX.4.10.10008090004530.22030-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I saw a couple of posts from people who seem to have the recent kernels
> (2.2.17pre1[3-5]-ben1) running on a 1999 Powerbook.
> Unfortunately, I have still the same problems with the backlight control
> that first appeared with 2.2.17pre10-ben1, i.e.
>
>  1. {Fn-,}F[12] don't adjust brightness
>  2. After wakeup from sleep, the backlight remains dark

Should be fixed in BenH's current tree, he said he was going to do it this
past weekend. The pmu backlight controller didn't get registered on the
Lombard (and possibly Wallstreet) because the backlight-control property
is missing on these machines.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
