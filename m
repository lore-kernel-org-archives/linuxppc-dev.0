To: zburgess@redsonic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel 2.4.3 on TQM823L 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 15 Aug 2001 17:18:52 PDT."
             <200108151718.AA2709455104@redsonic.com>
Date: Thu, 16 Aug 2001 08:54:16 +0200
Message-Id: <20010816065422.070F210CBA@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200108151718.AA2709455104@redsonic.com> you wrote:
>
> Thanks to help from here and elsewhere, I have my TQM823L booting
> and running on kernel 2.4.4. This is well and good, but I have been
> asked to get 2.4.3 to work on the same board. Here I have problems.

Why that? I cannoty think of any reason why  2.4.3  could  be  better
than a more recent kernel...

> Namely, the kernel bails silently while trying to start the mmu (at
> least that is what it appears to happen).

I think you are wrong. All cases I've see n so far where people  said
"it crashes when enabling the MMU" were just misinterpretation of the
facts.

...
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
>
> which looks good to me.

When you don't see ANY boot messages at all, you can be  pretty  sure
that you missed to adapt the Linux board info structure to the layout
passed  by  PPCBoot.  See  the  PPCBoot  README  about  the necessaru
changes.

> So, my question is, what is the big change between 2.4.3 and 2.4.4

The big difference is that I didn't adapt that one for the TQM ;-)

> (I have tried stock versions of each from kernel.org)? Is it worth

So far, the BitKeeper sources seems a better place to start for me.

> the time to try to make it work?

No. IMHO it's just wasted effort. You don't get  anything  which  you
don't alredy have (except some old bugs).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A consultant is a person who borrows your watch, tells you what  time
it is, pockets the watch, and sends you a bill for it.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
