Message-ID: <36D9B8E7.60C9F9B@wanadoo.fr>
Date: Sun, 28 Feb 1999 22:45:11 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: mlan@cpu.lu
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.2 compilation errors
References: <199902282049.VAA06261@piglet.cpu.lu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:

> On  26 Feb, this message from Martin Costabel echoed through cyberspace:
> [concerning compile poblems with 2.2.2 re semaphores]
> > I have a file kernel222-samba.diff that patches these 2 files. It
> > is only 5kB, so this is the simplest way to go.
> 
> Hmmm... for me, this is not enough.
> 
> I get errors in drivers/scsi/scsi_error.c like this:
> 
> scsi_error.c: In function `scsi_error_handler':
> scsi_error.c:1975: structure has no member named `owner'

Seems you don't have the same sources as I. You're sure that's plain
Linus 2.2.2? Not 2.2.1?
 
> The structure it complains about is struct semaphore, as defined in
> include/asm/semaphore.h
> 
> Now, for PPC, we have a different (simpler) definition of struct
> semaphore, lacking some of the members that i386 has. Obviously, these
> members are referenced in drivers/scsi/scsi_error.c.

I don't understand what you are talking about. The struct semaphore in
include/asm-i386/semaphore.h in 2.2.2 has the same members as the one in
include/asm-ppc/semaphore.h.

--
Martin

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
