Date: Tue, 21 Aug 2001 03:49:54 -0700
From: Matt Porter <mporter@mvista.com>
To: Dag Nygren <dag@newtech.fi>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPC embedded plans ?
Message-ID: <20010821034954.A27297@cx258813-a.chnd1.az.home.com>
References: <20010821065240.1853.qmail@dag.newtech.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010821065240.1853.qmail@dag.newtech.fi>; from dag@newtech.fi on Tue, Aug 21, 2001 at 09:52:40AM +0300
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Aug 21, 2001 at 09:52:40AM +0300, Dag Nygren wrote:
>
> Hi,
>
> I have a working 2.4.2 port for a board for SBS-or (VG4) here
> and wanted to migrate this port to 2.4.9.
>
> Checking out the sources I think I  can notice that there is a strong
> push towards some kind of "one file" machine definition.
>
> Is this right ?

More or less. Improving the abstraction layer is a continued focus
of development efforts.

> And what would be the best 2.4.9 to start out with ?

linuxppc_2_4_devel is the only sane place to develop new board ports.
See the thread, "PPC bk repos reorg" in the linuxppc-commit archives
for information on getting a copy of the tree.  Go to bitkeeper.com
to get a copy of BK for your system.

> Any written policy on the setup of the machine dependant stuff ?

No. Subscribe to the linuxppc-commit list and read the back archives
to see discussion of how we do things.
http://source.mvista.com/cgi-bin/mailman/listinfo/linuxppc-commit

Read the source and follow one of the many examples (K2, Spruce, etc.)

> Any way of getting my board defs into the official (?) PPC source tree ?

When you have _clean_ patches versus linuxppc_2_4_devel, post them
publicly.

--
Matt Porter
MontaVista Software, Inc.
mporter@home.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
