Message-ID: <3B98F4D4.ACA03465@acm.org>
Date: Fri, 07 Sep 2001 09:24:52 -0700
From: Ira Weiny <iweiny@acm.org>
MIME-Version: 1.0
To: diciaa@rpi.edu, linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Cardbus issues on TiBook
References: <3B97DA58.6894B342@acm.org> <20010906171002.26712d35.armando@nycap.rr.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


First off thanks for the reply.  However...

Armando Di Cianno wrote:
>
> On Thu, 06 Sep 2001 13:19:36 -0700
> Ira Weiny <iweiny@acm.org> wrote:
>
> > As some of you may know I am trying to get an IBM microdrive working on
> > my TiBook.  I know there is an issue with irq's which I am trying to
> > work out but I have run into another issue I don't understand.
>
> Uhmm, I have my microdrive working fine on my TiBook.  It maintains a happy little crypto filesystem for quick and easy removability. Ahh, the joys of being paranoid.
>

Well I followed your directions.  Built the pcmcia stuff into the
kernel, ide-cs as a module.  Got the latests pcmcia 3.1.29 package and
built it.  And used your address.  This seems to fix the "cat
/proc/ioports" issue.  But the machine will still lock up and turn off
when I insert the card.  And XMON reveals I am at the same spot
(actual_try_to_identyfy).

So my questions to you are:

1) could I get your .config file for the kernel.  Maybe I have some
other thing I am missing.

2) Which Microdrive and PCCard adapter are you using.  I have the 1Gig
and am using the adapter it came with.  Maybe there is an isuue with the
adapter I have.

Thanks for your reply,
Ira Weiny
iweiny@acm.org

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
