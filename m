Message-Id: <199906231213.OAA00419@piglet.cpu.lu>
Date: Wed, 23 Jun 1999 14:13:25 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: MESH problems in 2.2.x
To: Geert.Uytterhoeven@cs.kuleuven.ac.be
cc: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.10.9906221455110.5853-100000@michelin.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  22 Jun, this message from Geert Uytterhoeven echoed through cyberspace:
> So to boot recent kernels when you have sync-capable devices on the MESH, two
> conditions have to be met:
> 
>   - boot 2.1.130 first
>   - mesh_sync_targets = 0 (setting CONFIG_SCSI_MESH_SYNC_RATE=0 doesn't work)
> 
> Anyone else seeing this?

No:

scsi0 : MESH
scsi1 : 53C94
scsi : 2 hosts.
mesh: target 1 synchronous at 10.0 MB/s
  Vendor: IBM       Model: DFHSS1F       !c  Rev: 1717
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
mesh: target 2 synchronous at 10.0 MB/s
  Vendor: IBM       Model: DCAS-34330        Rev: S65A
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi0, channel 0, id 2, lun 0
mesh: target 3 synchronous at 5.0 MB/s
  Vendor: MATSHITA  Model: CD-ROM CR-8008    Rev: 8.0e
  Type:   CD-ROM                             ANSI SCSI revision: 02

Works perfectly well with kernel 2.2.8.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
