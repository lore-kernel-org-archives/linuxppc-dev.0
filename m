Message-Id: <200101191711.f0JHBXm09695@denx.local.net>
To: Jeff Hartmann <jhartmann@valinux.com>
cc: michdaen@iiic.ethz.ch, dri-devel@lists.sourceforge.net,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 19 Jan 2001 09:40:30 MST."
             <3A686DFE.9030308@valinux.com>
Date: Fri, 19 Jan 2001 18:11:33 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <3A686DFE.9030308@valinux.com> Jeff Hartmann wrote:
>
> I dunno if the kgdb patch works on powerpc, but you might try it.  You
> could single step through this code since your not at a point where
> interrupts are disabled.
>
> Unfortunately kdb (built-in kernel debugger) does not work on the
> powerpc.  It is REALLY useful when your debugging code when interrupts

OTOH on many PPC systems you can just hook up a BDM / JTAG  debugger,
which  provides  a  tool  which  is even more powerful (since you can
freeze the whole CPU, including all internal timers etc.).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Only in our dreams we are free. The rest of the time we neeed  wages.
                                    - Terry Pratchett, _Wyrd Sisters_

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
