Date: Sun, 4 Mar 2001 17:30:17 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: sym53c875 in 2.4.2
Message-ID: <20010304173017.A903@opus.bloom.county>
References: <Pine.LNX.4.05.10103021932200.480-100000@callisto.of.borg> <20010303191920.A2396@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010303191920.A2396@opus.bloom.county>; from trini@kernel.crashing.org on Sat, Mar 03, 2001 at 07:19:20PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Mar 03, 2001 at 07:19:20PM -0700, Tom Rini wrote:
>
> On Fri, Mar 02, 2001 at 07:51:21PM +0100, Geert Uytterhoeven wrote:
>
> > I just tried the current bk linuxppc_2_4 on my CHRP LongTrail with Sym53c875
> > card. The Sym53c8xx driver fails downloading the SCSI scripts, and keeps trying
> > ad infinitum.
> >
> > At first sight, the kernel seems to work when I disable the Sym53c8xx driver
> > with `sym53c8xx=excl:0x1400'. It boots to a shell from the MESH.
>
> Er, the very current 2_4?  Paulus just commited some changes which boil down
> to we have phys_to_bus (or so) and can use the stock driver.

And, the 2_4/2_5 merged tree i've got locally and will be pushing into 2_5
shortly works w/ my 53c895 anyways (Booted and got 3 disks on 2 buses).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
