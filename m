Message-Id: <199906242144.XAA00300@piglet.cpu.lu>
Date: Thu, 24 Jun 1999 23:44:31 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: MESH problems in 2.2.x
To: Geert.Uytterhoeven@cs.kuleuven.ac.be
cc: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.10.9906240953080.4063-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  24 Jun, this message from Geert Uytterhoeven echoed through cyberspace:
>> > So to boot recent kernels when you have sync-capable devices on the MESH, two
>> > conditions have to be met:
>> > 
>> >   - boot 2.1.130 first
>> >   - mesh_sync_targets = 0 (setting CONFIG_SCSI_MESH_SYNC_RATE=0 doesn't work)
>> > 
>> > Anyone else seeing this?
>> 
>> No:
>> 
>> scsi0 : MESH
>> scsi1 : 53C94
>> scsi : 2 hosts.
>> mesh: target 1 synchronous at 10.0 MB/s
>>   Vendor: IBM       Model: DFHSS1F       !c  Rev: 1717
>>   Type:   Direct-Access                      ANSI SCSI revision: 02
>> Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
[other drives deleted]

I might add that this is on a PowerMac 7600.

> Then it's my QUANTUM FIREBALL_TM3200S 300X :-(

Hmmm... I remember that in the early (and glorious ;-) days of MkLinux
DR2.1, there were lots of problems with the 7600's original internal
drives, being mostly Quantum Fireball TM1280S drives. I don't remeber
the problems clearly, but one of the solutions was to move the Quantum
drive to an ID different from 0. David Gatwood might remember what the
issue was....

On the other hand, I'm not sure the MESH in my 7600 is the same as the
one on your motherboard (except the name and the registers, maybe); so
that might be an explanation for your problems as well. For the record,
the MESH on the 7600 is integrated inside GrandCentral, an Apple ASIC
on the PCI bus, that handles the rst of the IO as well.

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
