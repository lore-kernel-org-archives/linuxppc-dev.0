Date: Thu, 4 Mar 2004 09:28:13 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: uncached user space mapping with mmap() ???
Message-ID: <20040304172813.GB1559@gate.ebshome.net>
References: <2C1BAF8F8E1DD611862B0002A5D4C3FC02B6CFC6@renexch3.rennes.thmulti.com> <40473EC2.1010400@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <40473EC2.1010400@imc-berlin.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Mar 04, 2004 at 03:35:46PM +0100, Steven Scholz wrote:
> >There's no need to implement kernel side stuff. /dev/mem is enough.
>
> So why will people need their own mmap() driver if this kind of things
> can be done via /dev/mem ???

There are CPUs (e.g. PPC440) where you cannot use /dev/mem to
map I/O memory. In case of PPC440 it isn't in 4GB address space that
/dev/mem can access.

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
