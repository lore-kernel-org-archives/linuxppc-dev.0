Date: Thu, 11 Mar 1999 09:42:07 +1100
Message-Id: <199903102242.JAA08373@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: hub@point-barre.fr
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <19990310152621.H896@giordino.point-barre.fr> (message from
	Hubert Figuiere on Wed, 10 Mar 1999 15:26:21 +0100)
Subject: Re: Sound drops
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <19990310152621.H896@giordino.point-barre.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hubert Figuiere <hub@point-barre.fr> wrote:

> I don't like to work in silence, so I usually play back a 
> bunch of mp3 with xaudio under Linux PPC from my PowerBook.
> 
> The problem is that I get a lot of sound drops like if the machine
> were "mono-tasking". I have never had this with PC hardware under Linux.
> 
> It appears that those drops occurs when doing intensive graphics like
> a Netscape redrawing or a huge text scroll within an xterm. This happens
> with Xpmac or XFB_Dev.

One thing to try is `hdparm -u1 /dev/hda'.  That sets the IDE driver
to allow interrupts during transfers to/from your hard disk.  I don't
know if it will help in your particular case, but it's worth trying.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
