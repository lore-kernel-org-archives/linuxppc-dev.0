Message-Id: <m13w4pW-001SzcC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Re: glibc and kernel build problems (EST8260)
To: ford@vss.fsi.com (Brian Ford)
Date: Wed, 15 Nov 2000 10:50:34 -0500 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <Pine.GSO.4.21.0011150916280.493-100000@eos> from "Brian Ford" at Nov 15, 2000 09:25:39 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Do you know if their 8260 glibc is compiled for soft or hard float?  Also,
> did they apply the less than 32 byte cache line patch?  That is removing
> optimization for the 8260 instead of fixing things.

MontaVista has the source RPM's available, so you should be able to
rebuild everything from scratch.  If it doesn't meet your needs, then
you can change it.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
