Message-Id: <199901112144.WAA00523@piglet.cpu.lu>
Date: Mon, 11 Jan 1999 22:44:12 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Strange tar hang....
To: jk@espy.org
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <v04103c34b2bf2769a22d@[206.163.71.146]>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


An additional thought crossed my mind....

On  10 Jan, this message from Joel Klecker echoed through cyberspace:
> tar tries to look up UIDs and GIDs in the tar file and match them to 
> local users. With the default /etc/nsswitch.conf, it will end up 
> trying NIS and other services.

Ah, /etc/nsswitch.conf. So it was the glibc package that made the
timeout reappear! In fact, I did just upgrade glibc before I saw the
timeout again...

Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
9, Montee St. Crepin           |    Ask Questions.  Make Mistakes.
L-1365 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
