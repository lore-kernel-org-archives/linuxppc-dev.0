Message-Id: <200004090913.LAA00374@piglet.grunz.lu>
Date: Sun, 9 Apr 2000 11:13:55 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Blue & White & SCSI & Ultra 2 SCSI & Kernel > 2.2.10 -> No Disk
 s
To: jpd@yami.w-d.org
cc: rshaw@linuxppc.org, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <38EF50E4.872D76ED@w-d.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   8 Apr, this message from John Doty echoed through cyberspace:
> My Yosemite G3 (Rev 2) has *two* SCSI cards: an Adaptec 2930CU, and an
> Adaptec 2940U2B (Ultra 2 Wide). Last summer, my son Matt (who
> occasionally posts here on comp.os.linux.powerpc) set it up as a
> LinuxPPC machine with a 2.2.10 kernel from Robert Shaw's site.  As a
> compute/file server, it has been great.
>
> However,  attempts to upgrade to a more recent kernel invariably
> encountered SCSI problems. The most common symptom was an inability to
> mount the root  filesystem.
>
> We have finally gotten partway to the bottom of this. Apparently, if the
> 2930 controller is present the kernel cannot find the 2940 controller
> (and the 2940 has the disks on it). With the 2930 pulled (I don't really
> need it the way I'm currently using the system), SCSI works fine with
> the newer kernels.

Isn't this the OF resource assignment problem discussed here some time
ago? Have a look at the mailing list archives...


Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
