Message-ID: <36C14B5E.38CF@post.uni-bielefeld.de>
Date: Wed, 10 Feb 1999 10:03:28 +0100
From: "Jens Ch. Restemeier" <jenschrr@post.uni-bielefeld.de>
Reply-To: jenschrr@post.uni-bielefeld.de
MIME-Version: 1.0
To: Amos <quoll@nutopia.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: libglib? where is it?
References: <199902100324.VAA14271@lists.linuxppc.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Amos wrote:
> 
> I'm trying to install the gnome rpms I found @
> <ftp://linuxppc.cs.nmt.edu/pub/linuxppc/gnome/ppc/> Every many of the
> packages say they require a libglib package, but I can't find it anywhere!?
> I'm running R5 RawHide 1.something (I'm in MacOS right now...). Did I miss a
> package when I installed R5 originally (I'm sure I did, but what one?)

"glib" is related to gtk+. If gtk+ programs (like GIMP-1.1) work, you'll
propably already have glib, and you just need to override the
dependancies (--nodeps).

Jens


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
