Date: Thu, 24 Jun 1999 09:53:53 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Michel Lanners <mlan@cpu.lu>
cc: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
Subject: Re: MESH problems in 2.2.x
In-Reply-To: <199906231213.OAA00419@piglet.cpu.lu>
Message-ID: <Pine.LNX.4.10.9906240953080.4063-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 23 Jun 1999, Michel Lanners wrote:
> On  22 Jun, this message from Geert Uytterhoeven echoed through cyberspace:
> > So to boot recent kernels when you have sync-capable devices on the MESH, two
> > conditions have to be met:
> > 
> >   - boot 2.1.130 first
> >   - mesh_sync_targets = 0 (setting CONFIG_SCSI_MESH_SYNC_RATE=0 doesn't work)
> > 
> > Anyone else seeing this?
> 
> No:
> 
> scsi0 : MESH
> scsi1 : 53C94
> scsi : 2 hosts.
> mesh: target 1 synchronous at 10.0 MB/s
>   Vendor: IBM       Model: DFHSS1F       !c  Rev: 1717
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
> mesh: target 2 synchronous at 10.0 MB/s
>   Vendor: IBM       Model: DCAS-34330        Rev: S65A
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> Detected scsi disk sdb at scsi0, channel 0, id 2, lun 0
> mesh: target 3 synchronous at 5.0 MB/s
>   Vendor: MATSHITA  Model: CD-ROM CR-8008    Rev: 8.0e
>   Type:   CD-ROM                             ANSI SCSI revision: 02

Then it's my QUANTUM FIREBALL_TM3200S 300X :-(

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
