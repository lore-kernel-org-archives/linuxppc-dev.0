Subject: Re: Need a Linux PPC kernel which supports the Radeon Mobility 9600
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ken Offer <koffer@arlut.utexas.edu>
Cc: linuxppcdev <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <4F1C744C-FFE6-11D7-9F9F-000393467F1A@arlut.utexas.edu>
References: <4F1C744C-FFE6-11D7-9F9F-000393467F1A@arlut.utexas.edu>
Content-Type: text/plain
Message-Id: <1066317895.1407.154.camel@gaston>
Mime-Version: 1.0
Date: Thu, 16 Oct 2003 17:24:56 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> I have not.  I wasn't aware of "module-init-tools".  It shouldn't be
> necessary to build and link the 2.6 kernel, should it?

It is necessary for the modules stage to work properly, at least
for the depmod to work

> By the way, I went ahead and installed the 2.6 kernel it built (I
> figured it would be missing some modules, but what the heck...)  X11
> appeared to work with the radeonfb driver.  KDE asked me for the time,
> date, etc.  However, just after I attempted to log in KDE croaked and
> locked up the system while "initializing services".  Since it was a
> hard-freeze and I didn't get a kernel opps, I have no feedback other
> than this.  I'm hoping it has nothing to do with the radeonfb driver.

Probably not.

> Right now I'm attempting to back-port the 2.6 radeonfb driver to the
> 2.4 kernel myself.  I don't know the driver as well as you Ben, but I
> need to make some sort of progress.  I'm betting the 2.6 kernel is
> probably too bleeding-edge right now for a deliverable system. :)
>

I did make some backporting (not the complete set of changes, but
some more recent board support).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
