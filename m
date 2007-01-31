Return-Path: <parabelboi@bopserverein.de>
Date: Wed, 31 Jan 2007 12:25:33 +1100
From: Christian Krafft <parabelboi@bopserverein.de>
To: Carl Love <cel@us.ibm.com>
Subject: Re: [Cbe-oss-dev] [RFC, PATCH 4/4] Add support to OProfile for
	profiling Cell BE SPUs -- update
Message-ID: <20070131122533.5ef22907@localhost>
In-Reply-To: <1170199869.5235.38.camel@dyn9047021078.beaverton.ibm.com>
References: <45BE4ED0.5030808@us.ibm.com> <45BE4FA4.9020105@us.ibm.com>
	<200701300839.05144.arnd@arndb.de> <45BFBB78.7060907@us.ibm.com>
	<1170199869.5235.38.camel@dyn9047021078.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, oprofile-list@lists.sourceforge.net,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 30 Jan 2007 15:31:09 -0800
Carl Love <cel@us.ibm.com> wrote:

> An LFSR sequence is similar to a pseudo random number sequence. For a 24
> bit LFSR sequence each number between 0 and 2^24 will occur once in the
> sequence but not in a normal counting order.  The hardware uses the LFSR
> sequence to count to since it is much simpler to implement in hardware
> then a normal counter.  Unfortunately, the only way we know how to
> figure out what the LFSR value that corresponds to the number in the
> sequence that is N before the last value (0xFFFFFF) is to calculate the
> previous value N times.  It is like trying to ask what is the pseudo
> random number that is N before this pseudo random number?

That should be no problem.=20
You can just revers your algorithm and let it run x times instead of 0xFFFF=
FF-x.

>=20
> I will add a short comment to the code that will summarize the above
> paragraph.
> [snip]
>=20
> _______________________________________________
> cbe-oss-dev mailing list
> cbe-oss-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/cbe-oss-dev


--=20
Mit freundlichen Gr=FCssen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,=20
Linux Kernel Development
IT Specialist
