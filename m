To: Hihn Jason <JasonHihn@DANFOSS.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Adding monochrome support for 823e 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 29 Aug 2002 17:43:04 +0200."
             <E1836A7F3557D311A14000805F9F36FC0141C860@usdfo011.usac.danfoss.net>
Date: Thu, 29 Aug 2002 18:26:07 +0200
Message-Id: <20020829162612.9D7FB1182F@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <E1836A7F3557D311A14000805F9F36FC0141C860@usdfo011.usac.danfoss.net> you wrote:
>
> I've completed the kernel work for using the 832e in monochrome mode. It
> requires changes to drivers/video/fbcmap.c. You need to add a palette for
> it's monochrome mode that looks like:

Ummm...

> Then you have to do some work in arch/ppc/8xx_io/lcd832.c where indicated.
> Without the work above, you may get garbage. I don't think you'd ever get
> right output.

We have support for monochrome LCD in our kernel source tree (see the
CONFIG_EDT32F10 configuration, as used by teh R360MPI board). We  did
not need any changes to drivers/video/fbcmap.c.

> I just wanted to get this out there so it goes in the archives.

I guess to get anything into the  "archives"  you  should  prepare  a
proper patch (including against which kernel version you built it).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
...the increased productivity fostered by a friendly environment  and
quality  tools  is  essential  to  meet  ever  increasing demands for
software.               - M. D. McIlroy, E. N. Pinson and B. A. Tague

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
