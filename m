Message-Id: <200008190826.KAA17167@denx.local.net>
To: "Frank Smith" <smith@amirix.com>
cc: clark@esteem.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPCBoot memory mapping problems 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 18 Aug 2000 23:10:44 -0300."
             <00Aug18.231049adt.7303@dragon.appliedmicro.ns.ca>
Date: Sat, 19 Aug 2000 10:26:25 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <00Aug18.231049adt.7303@dragon.appliedmicro.ns.ca>
Frank Smith wrote:
>
> > mapped at 0xC0000000? If it loads at address 0 how do I remap it to
> > 0xC0000000 once the kernel starts? Is there any way to force the kernel to
>
> Basically, the kernel boot process should be doing this *for* you.
>
> Part of the kernel boot process is to set up a memory mapping from
> virtual C0000000 to physical 00000000, and then enable address translation.

Right, but just to make this absolutely clear: this  is  done  within
the Linux kernel, you don't have to do anything for that in PPCBoot.

> > run in lower memory?
>
> I doubt it.  It shouldn't be necessary, tho.

There is no need to do anything like that in PPCBoot.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Comparing information  and  knowledge  is  like  asking  whether  the
fatness  of  a  pig  is more or less green than the designated hitter
rule."                                               - David Guaspari

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
