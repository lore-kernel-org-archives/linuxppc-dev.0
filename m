Subject: Re: Runtime Altivec detection
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: Nathan Ingersoll <ningerso@ruralcenter.org>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3E68D5BF.1050906@embeddededge.com>
References: <20030307164753.GA5240@ruralcenter.org>
	 <3E68D5BF.1050906@embeddededge.com>
Content-Type: text/plain
Message-Id: <1047058865.12206.44.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 07 Mar 2003 18:41:05 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2003-03-07 at 18:24, Dan Malek wrote:
> Nathan Ingersoll wrote:
>
> > I've recently been working on some Altivec optimizations for a library,
> > and was looking for a relatively clean way to perform runtime detection.
>
> For some time now the Linux kernel has provided support for emulating
> the 'mfspr rd, PVR' instruction in user space.  Do this once, get the
> PVR and determine the processor type.
>
> You can also just read /proc/cpuinfo and search for the 'cpu :' line.
> It will indicate the processor type and if altivec is supported.
>
> There are probably other ways as well....

There's a much better way. The kernel passes down CPU features
bits down to userland via ELF AUX tables.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
