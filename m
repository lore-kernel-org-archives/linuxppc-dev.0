From: Joe Green <jgreen@mvista.com>
To: Mark Hatle <fray@mvista.com>,
	"Dr. Craig Hollabaugh" <craig@hollabaugh.com>
Subject: Re: init fails w/ new build of gcc & glibc
Date: Fri, 17 Aug 2001 15:28:50 -0700
Content-Type: text/plain
Cc: Mark Pilon <mark.pilon@minolta-qms.com>,
	linuxppc-embedded@lists.linuxppc.org
References: <3B7D82D5.DD98A109@minolta-qms.com> <5.1.0.14.0.20010817160848.00abfec0@spudcentral.com> <3B7D9921.8CB7F6AE@mvista.com>
In-Reply-To: <3B7D9921.8CB7F6AE@mvista.com>
MIME-Version: 1.0
Message-Id: <01081715323600.27039@minotaur.mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark Hatle wrote:
> But on a processor like the 405 it "can be" compatable using the
> CONFIG_MATH_EMULATION.  The catch is that you have a lot more overhead
> doing emulation.... (The emulation itself is pretty fast, certainly no
> slower then the software code invoked in -msoft-float..)

In theory, the compiler can also optimize user-space emulation better
(move code around, use different registers).  In practice, I don't know
that this has a significant effect.

--
Joe Green <jgreen@mvista.com>
MontaVista Software, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
