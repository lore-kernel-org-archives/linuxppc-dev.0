Date: Mon, 10 Jan 2000 17:52:59 +0200 (EET)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Olaf Hering <olh@suse.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] MacAlly 2-buttons mouse support for 2.2.14
In-Reply-To: <20000110154946.D7197@suse.de>
Message-ID: <Pine.LNX.4.21.0001101729470.25529-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 10 Jan 2000, Olaf Hering wrote:

> 
> On Mon, Jan 10, Kostas Gewrgiou wrote:
> 
> > > Right mouse button is CMND , middle mouse button is CTRL.
> > > Would be nice to get some feedback. 
> 
> >   Hmm how are you going to get double clicks with this ? 
> > Also keep in mind that many window managers/programs use
> > ctrl|meta|alt-mousebutton.
> > 
> > I still feel that at least for X it should (and can) be 
> > handled from inside X and not from the kernel. We still
> > need something for the console though.
> 
> It work also on the console. I guess there is no easy way for
> ALT+double_click.
> 
> Or do you miss something? It is for the copy&paste function, I will
> check what I can do to solve the problem with Xterm. You can not change
> the size of the font.
> If someone really need a application that depends on "complex mouse
> clicks" ;-) then go and by a more button mouse.

  I mean that you can map keyboard keys to mouse clicks under X *without* any
kernel changes. Take a look at http://people.a2000.nl/omoerbe/ for a better
description.  

> 
> BTW, where can I get a more button ADB mouse?
> 
  Can't help there, at least in Greece its much easier (and cheaper) to find/buy
a usb pci card :(.
> 
> Gruss Olaf
> 
> 

 Kostas Gewrgiou


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
