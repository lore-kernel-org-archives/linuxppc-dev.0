Date: Wed, 10 Mar 1999 13:41:41 -0500 (EST)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Hubert Figuiere <hub@point-barre.fr>
cc: LinuxPPC Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Sound drops
In-Reply-To: <19990310152621.H896@giordino.point-barre.fr>
Message-ID: <Pine.LNX.3.96L.990310133932.1996F-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 10 Mar 1999, Hubert Figuiere wrote:
> 
> I don't like to work in silence, so I usually play back a 
> bunch of mp3 with xaudio under Linux PPC from my PowerBook.

xaudio? Haven't heard of it.

> The problem is that I get a lot of sound drops like if the machine
> were "mono-tasking". I have never had this with PC hardware under Linux.
> 
> It appears that those drops occurs when doing intensive graphics like
> a Netscape redrawing or a huge text scroll within an xterm. This happens
> with Xpmac or XFB_Dev.

Try adding a buffer switch - for example, mpg123 takes -b1024 where 1024 is
the size of the buffer in K, IIRC. I don't have any idea what xaudio is, but
I think most sound playback programs have specifiable buffers.

-Hollis


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
