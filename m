Subject: Re: Runtime Altivec detection
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Magnus Damm <damm@opensource.se>
Cc: dan@embeddededge.com, ningerso@ruralcenter.org,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030307185552.0da9897b.damm@opensource.se>
References: <20030307164753.GA5240@ruralcenter.org>
	 <3E68D5BF.1050906@embeddededge.com>
	 <1047058865.12206.44.camel@zion.wanadoo.fr>
	 <20030307185552.0da9897b.damm@opensource.se>
Content-Type: text/plain
Message-Id: <1047060372.12202.46.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 07 Mar 2003 19:06:12 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2003-03-07 at 19:55, Magnus Damm wrote:
> > There's a much better way. The kernel passes down CPU features
> > bits down to userland via ELF AUX tables.
>
> Any pointers where I can find information about that?

Well... I know how the kernel pass them down to glibc, but
I don't know how a userland app can retreive them :)

The actual bitmask is defined in kernel's include/asm/cputable.h,
there are 2 sets of feature bits, one for kernel internal usage
and one passed down to userland.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
