Date: Tue, 8 Aug 2000 19:22:44 +0200 (MET DST)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Backlight control on Lombard PB
In-Reply-To: <200008080459.XAA04970@lists.linuxppc.org>
Message-ID: <Pine.SOL.3.95.1000808191003.1384C-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I saw a couple of posts from people who seem to have the recent kernels
(2.2.17pre1[3-5]-ben1) running on a 1999 Powerbook.
Unfortunately, I have still the same problems with the backlight control
that first appeared with 2.2.17pre10-ben1, i.e.

 1. {Fn-,}F[12] don't adjust brightness
 2. After wakeup from sleep, the backlight remains dark

At least it does not seem to crash anymore when I try to repeatedly wake
it up, but the only thing I can do at that point is to reboot.
Has anyone one of these kernels working on a Lombard and is actually able
to use sleep (or adjust monitor brightness)?

Besides, the keycodes 10 and 50 (less/greater and asciicircum/degree) on
the german keyboard seem to have been swapped in pre13-pre15.

Thanks for any feedback,
							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
