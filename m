Date: Mon, 4 Jan 1999 10:18:56 -0700 (MST)
From: Brad Midgley <brad@pht.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Peter Abrahamsen <p1rabbit@halcyon.com>
Subject: Re: 2.2.0pre2 SCSI problems, more (fwd)
In-Reply-To: <Pine.LNX.4.03.9901041423130.7235-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.LNX.3.95.990104100936.8496A-100000@pacific.pht.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hey!

that's the SAME drive that aborts for me in 2.2.0p4. mine is also
connected to mesh. my 2.1.30 identifies it as: 

Vendor: QUANTUM   Model: FIREBALL1280S     Rev: 630G

i don't see it blacklisted. something just makes it want to abort now. the
scary thing about this is this drive ships STANDARD in 1gig 7500's. that's
a lot of computers that suddenly can't run linux. 

peter, did you ever try booting mklinux? it always got an abort when it
came across that drive... 

brad

On Mon, 4 Jan 1999, Geert Uytterhoeven wrote:

> 
> ---------- Forwarded message ----------
> Date: Thu, 31 Dec 1998 15:03:02 -0800 (PST)
> From: Peter Abrahamsen <p1rabbit@halcyon.com>
> To: Tom Rini <tmrini@ntplx.net>,
>      Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
> Subject: 2.2.0pre2 SCSI problems, more
> 
> Hallo!
> 
>   I have been having troubles with SCSI on all kernels after 2.1.130.
> Actually, the 2.1.130 I'm using is prebuilt so that may have something to do
> with it. 2.1.127 (built by myself) worked fine. Here is an excerpt from my
> boot log for 2.2.0pre2:
> 
> scsi0: MESH
> scsi1: 53c94
> scsi: 2 hosts
> mesh: target 0 aborted        <-- ??? this is my problem...
> mesh: target 2 synchronous at 5 MB/s
> Vendor: QUANTUM Model: FIREBALL SE2.1s
> [followed by normal scsi information on the rest of my busses]
> 
>   Booting from 2.1.130, the /proc/scsi/scsi entry for the device skipped
> above is:
> 
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>    Vendor: QUANTUM Model: FIREBALL1280S Rev: 630G
>    Type: Direct-Access
> 
>   On the boot previous to that one, it seemed to go fine, until the
> following:
> 
> Machine check in kernel mode.
> Caused by (from msr) : regs cba7dbf0 Machine check signam - probably due to
> mm fault with mmu off
> NIP: D0832290 XER: E000BE6F CR: D0832238 REGS: cba7dbf0 TRAP: 0200
> NSR: 00001030 TASK: cba7c000 [76] 'insmod' mm -> pgd cbc9000
> 
>   that's copied down from a stickie, so maybe a number or formatting is wrong
> somewhere... So are the boot messages for SCSI stuff above, for that matter.
>   Normally (I only got that Machine check thing once) it drops me to single
> user mode, and gives me a prompt. Mount lists /dev/sdb5 mounted at / (which
> is as it should be, except that it had told me earlier that my ZIP drive had
> become sdb since my first drive wasn't detected).
> 
> I am using debian-powerpc potato, libc6 2.0.100... Please tell me if there
> is any more information I can give you.
> 
> Thanks,
> 
> Peter
> 
> --
> Peter Abrahamsen
> p1rabbit@halcyon.com
> http://www.halcyon.com/p1rabbit
> PGP: 0xC279D219: C080 6D6F 4492 C63D 20B7 8D41 8B17 C781 C279 D219
> 
> 
> 


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
