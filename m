Date: Mon, 1 Mar 1999 09:57:47 +1100
Message-Id: <199902282257.JAA01459@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: mlan@cpu.lu
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <199902282049.VAA06261@piglet.cpu.lu> (message from Michel
	Lanners on Sun, 28 Feb 1999 21:49:19 +0100 (CET))
Subject: Re: 2.2.2 compilation errors
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <199902282049.VAA06261@piglet.cpu.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners <mlan@cpu.lu> wrote:

> I get errors in drivers/scsi/scsi_error.c like this:
> 
> scsi_error.c: In function `scsi_error_handler':
> scsi_error.c:1975: structure has no member named `owner'
> 
> The structure it complains about is struct semaphore, as defined in
> include/asm/semaphore.h
> 
> Now, for PPC, we have a different (simpler) definition of struct
> semaphore, lacking some of the members that i386 has. Obviously, these
> members are referenced in drivers/scsi/scsi_error.c.

Linus put in the owner and owner_depth fields in struct semaphore
late in the 2.1 series, and then took them out again for 2.2.2.  You
must have an old copy of scsi_error.c.

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
