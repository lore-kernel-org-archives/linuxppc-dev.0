Message-Id: <199901112136.WAA00520@piglet.cpu.lu>
Date: Mon, 11 Jan 1999 22:36:47 +0100 (CET)
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


Hi there,

On  10 Jan, this message from Joel Klecker echoed through cyberspace:
>>Could this be a problem in the networking code of the kernel?
> 
> tar tries to look up UIDs and GIDs in the tar file and match them to 
> local users. With the default /etc/nsswitch.conf, it will end up 
> trying NIS and other services.

OK, that prevented the timeout; thanks for the tip. Question is, should
the timeout have occurred in the first place?

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
