From: "Stefano Coluccini" <s.coluccini@caen.it>
To: "Tom Rini" <trini@kernel.crashing.org>,
	"Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "Linux/PPC Development" <linuxppc-dev@lists.linuxppc.org>
Subject: RE: sym53c875 in 2.4.2
Date: Mon, 5 Mar 2001 09:22:19 +0100
Message-ID: <NDBBIFIMCKPOADMAJOKMIEKNCPAA.s.coluccini@caen.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20010304173017.A903@opus.bloom.county>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > I just tried the current bk linuxppc_2_4 on my CHRP LongTrail
> with Sym53c875
> > > card. The Sym53c8xx driver fails downloading the SCSI
> scripts, and keeps trying
> > > ad infinitum.
> > >
> > > At first sight, the kernel seems to work when I disable the
> Sym53c8xx driver
> > > with `sym53c8xx=excl:0x1400'. It boots to a shell from the MESH.
> >
> > Er, the very current 2_4?  Paulus just commited some changes
> which boil down
> > to we have phys_to_bus (or so) and can use the stock driver.
>
> And, the 2_4/2_5 merged tree i've got locally and will be pushing into 2_5
> shortly works w/ my 53c895 anyways (Booted and got 3 disks on 2 buses).

I have a 2_5 kernel, a Motorola MVME5100 with a sym53c875 based SCSI board
and it works fine.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
