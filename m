Message-ID: <366BEB45.C28@post.uni-bielefeld.de>
Date: Mon, 07 Dec 1998 15:50:45 +0100
From: "Jens Ch. Restemeier" <jenschrr@post.uni-bielefeld.de>
MIME-Version: 1.0
To: Hubert Figuiere <Hubert.Figuiere@solsoft.fr>
CC: Patrik Jonsson <patrik@ucolick.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: New XF68_FBDev - how to download?
References: <Pine.LNX.4.03.9812041606410.26444-100000@mercator.cs.kuleuven.ac.be> <Pine.SUN.3.95.981205180529.7735A-100000@helios.ucolick.org> <19981207120905.B2395@dirkpitt.solsoft.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hubert Figuiere wrote:
> 
> According to Patrik Jonsson <patrik@ucolick.org>:
> >
> > On Fri, 4 Dec 1998, Geert Uytterhoeven wrote:
> >
> > > New version at:
> > >
> > >     http://www.cs.kuleuven.ac.be/~geert/bin/XF68_FBDev-accel-ppc-19981204-2.gz
> >
> > Hi all,
> > how in the world do you get this file? When I try to save it in netscape,
> > it strips the .gz suffix, but doesn't seem to unzip the file. I can't
> > execute OR run gunzip on the thing I get...
> > I hate downloading binaries with netscape! Does anyone have any advice
> > here?
> 
> Try with lynx:
> 
> lynx \
> http://www.cs.kuleuven.ac.be/~geert/bin/XF68_FBDev-accel-ppc-19981204-2.gz \
> -dump >XF68_FBDev-accel-ppc-19981204-2.gz

I like "wget" to get http/ftp files from the shell. 
wget \
http://www.cs.kuleuven.ac.be/~geert/bin/XF68_FBDev-accel-ppc-19981204-2.gz

Jens

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
