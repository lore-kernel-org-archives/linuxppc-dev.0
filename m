Message-Id: <200010061357.PAA05385@denx.local.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Segmentation fault 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 06 Oct 2000 17:39:31 +0900."
             <00100618093700.11698@localhost.localdomain>
Date: Fri, 06 Oct 2000 15:57:36 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello H.S. Kim,

first of all: please fix your mail setup!!!

> From: "H.S. Kim" <root@localhost.localdomain>

"root@localhost.localdomain" is NOT a valid email address!

In message <00100618093700.11698@localhost.localdomain> H.S. Kim wrote:
>
> I compiled the binutil, gcc,  kernel and glibc without errors.
> binutil-2.20.0.26
> gcc-2.95.2
> mpc8xx-2.2.13
> glibc-2.1.3
...
> *** Result ***
> p = strrchr(filename,'/')  -> segmentation fault

Building a cross-development environment for the MPC8xx is a
non-trivial task. There is some description in the Embedded PPC
HOWTO, and there are ready to use build scripts and/or images, for
instance from our web page
(http://www.denx.de/solutions-en.html#CDK), from MontaVista, RedHat,
and others.

Most probably you have made a mistake when building GCC and/or glibc.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A bore is someone who persists in holding his own views after we have
enlightened him with ours.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
