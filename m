From: Cort Dougan <cort@fsmlabs.com>
Date: Thu, 2 May 2002 10:12:57 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>,
	Robert E Brose II <bob@kunk.jriver.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Dual G3's in Umax S900?
Message-ID: <20020502101257.C26017@host110.fsmlabs.com>
References: <8x1ycu1yp4.fsf@olof.informatik.uni-bremen.de> <20020502131439.13109@smtp.adsl.oleane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020502131439.13109@smtp.adsl.oleane.com>; from benh@kernel.crashing.org on Thu, May 02, 2002 at 03:14:39PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Those are definitely not SMP chips.  The lack of the tlbie broadcast is a
killer.  I did some work with a dual 750 and implemented the software
broadcast in software (the code is still in the kernel - but unused) and it
was a nightmare of inefficiency.  In most benchmarks it turned out to be a
net negative to use the second processor.

Please... please, make the world a safer place for us on the verge of
insanity OS people and don't do a SMP 750!

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
