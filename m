Date: Thu, 3 May 2001 20:38:38 +0100 (BST)
From: Dave Jones <davej@suse.de>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: John Fremlin <chief@bandits.org>,
	Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>,
	"Grover, Andrew" <andrew.grover@intel.com>,
	"Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
	<sfr@canb.auug.org.au>, <linux-arm-kernel@lists.arm.linux.org.uk>,
	<linuxppc-dev@lists.linuxppc.org>,
	Arjan van de Ven <arjan@fenrus.demon.nl>
Subject: Re: pmevent patch and PM
In-Reply-To: <20010502201653.A6711@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.31.0105032025260.13274-100000@athlon>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2 May 2001, Russell King - ARM Linux wrote:

> I've been specifically discussing the CPU clock switching issues
> with Erik, and we have the bones of a kernel-internal generic
> interface that should be suitable for both ARM and Intel SpeedStep

Interesting, Powertweak [http://powertweak.sourceforge.net] has had
this in development for a while (slowed down somewhat as I've been
busy with studies). So far we have basic AMD PowerNOW! support, and
have some pending stuff to be merged (VIA Cyrix & Transmeta support).

> The interface doesn't have anything to drive it yet - its literally
> an interface where you can say "please set my CPU clock speed to
> xxx MHz".

The code we have so far is in userspace. The clockspeed frobbing
will be moved to kernelspace as soon as my exams are over, and I
get some time to work on this.

The policies for adjusting the clockspeed sysctl have yet to be written,
but should slot into the framework we have quite easily.

Do you have a ptr to what you have done so far ?
Doing the kernel side part as platform independantly as possible
would make a lot of sense, and shouldn't be particularly difficult.

regards,

Dave.

--
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
