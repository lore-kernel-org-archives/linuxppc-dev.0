Date: Thu, 17 Dec 1998 10:21:03 +1100 (EST)
From: Nathan Hurst <njh@cs.monash.edu.au>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org, paulus@cs.anu.edu.au
Subject: Re: BootX, ramdisk and root device
In-Reply-To: <19981215143756.003692@mail.mipsys.com>
Message-ID: <Pine.LNX.3.96.981217095027.10484A-100000@central>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 15 Dec 1998, Benjamin Herrenschmidt wrote:

> I was wondering: Is there any case where a user may want to have both
> "Use RamDisk" and a specified root device ? 
I don't think so.

> Should I ignore the content of the root device field when ram disk is
> used ? 

This would make sense.

> (It still possible to
> force it by typing the parameter manually in the kernel args anyway).

Hence, if people know what they're doing, they can add it, but the rest of
us who just forgot to clear the field wont have problem.

> Similar issue: should I lookup and remove any "video=xxxx" option from
> the kenrnel args prior to booting the kernel when "no video driver" is
> checked or is this harmless ?

I think that anyone who puts this in will know what they're doing.

njh


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
