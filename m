Message-Id: <199903102111.WAA00669@piglet.cpu.lu>
Date: Wed, 10 Mar 1999 22:11:38 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Sound drops
To: hub@point-barre.fr
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19990310152621.H896@giordino.point-barre.fr>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  10 Mar, this message from Hubert Figuiere echoed through cyberspace:
> I don't like to work in silence, so I usually play back a 
> bunch of mp3 with xaudio under Linux PPC from my PowerBook.
> 
> The problem is that I get a lot of sound drops like if the machine
> were "mono-tasking". I have never had this with PC hardware under Linux.
> 
> It appears that those drops occurs when doing intensive graphics like
> a Netscape redrawing or a huge text scroll within an xterm. This happens
> with Xpmac or XFB_Dev.
>
> My question is: Is it a known bug of the sound drivers or is it a 
> hardware limitation ?

IIRC, there was such a question on /. recently. You might ant to look
over there.

I would rather attribute this symptom to a problem in X, where the X
server is allowed to monopolize much of the machine for redrawing. The
fact the our current X servers (all those I tried, even Xpmac_mga
accelerated for my Matrox) eat _huge_ amounts of CPU for all blitting
operations like scrolling etc.

There seems to be work to do on the X side of things....

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
