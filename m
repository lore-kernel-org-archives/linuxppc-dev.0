Date: Tue, 27 Jun 2000 13:41:55 -0400 (EDT)
From: "Mark S. Mathews" <mark@absoval.com>
To: Dan Malek <dan@netx4.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PLPRCR & Checkstop reset
In-Reply-To: <3957AB3D.7A0244D9@netx4.com>
Message-ID: <Pine.LNX.3.96.1000627133308.22108D-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hmmm.  I'm not exactly sure which 'kind' of reset I should be using.

What I'm trying to accomplish is getting "init 6" or "reboot" to work as
expected.  I.e. JLAPC (Just like a PC  ;-)

I'd like the reset to result a reset to the RPXU2 which restarts my kernel
via 'autoboot'.  Since the 'reset' command in the RPXU and U2 used the
checkstop thing, I figured it would would work OK for me.

I haven't yet studied the reset part of the 823 manual close enough to
figure out all of the available reset modes.

I'll defer to your expertise the selection of the 'right way' to do this.
;-)

Thanks,
-Mark

On Mon, 26 Jun 2000, Dan Malek wrote:

>
> Mark S. Mathews wrote:
>
> > We're using the mvista 2.2.13-3 kernel sources and I'd like to add a
> > software reboot capability.
>
>
> How do you actually want to reboot?  At one time, I had modified
> the kernel "gorom()" function to simply jump into the boot rom as
> if a reset occurred.  I should make this work again for many reasons.
>
> If you really want the hard reset, which in some cases on some
> designs will reset some external hardware sometimes, then the
> checkstop reset will do the trick.  This is often confused with
> performing a hard reset function, which really isn't the same thing.
>
> I will dig up the code for both cases.
>
>
> 	-- Dan
>
>


Mark S. Mathews

AbsoluteValue Systems      Web:    http://www.linux-wlan.com
P.O. Box 941149            e-mail: mark@linux-wlan.com
Maitland, FL 32794-1149    Phone:  407.644.8582
USA                        Fax:    407.539.1294


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
