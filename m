In-Reply-To: <199901131910.LAA28570@saul9.u.washington.edu>
Date: Thu, 14 Jan 1999 12:12:21 +0100
To: linuxppc-dev@lists.linuxppc.org,
        "David A. Gatwood" <marsmail@globegate.utm.edu>,
        a sun <asun@saul9.u.washington.edu>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Porting to NuBus PowerMacs
Message-Id: <19990114121221.005972@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 12, 1999, a sun <asun@saul9.u.washington.edu> wrote:

>so, ben, i guess i'll also need memory addresses/sizes as well. after
>perusing the m68k code, i think that's the only thing that i forgot to
>tell you about. this will essentially make bootx report essentially
>the same information as the m68k boot loader.

I'll download this bootloader and see what it does. I don't know exactly
how to get this memory map yet, it would be great if David could manage
to find the info ...

>well, my "oh so clever plan" is actually to use the gestalt
>information to mock up something that i pass to the m68k interrupt
>routines. presto! no more uglification of irq.c. given the
>similarities between the apus stuff and the nubus powermac stuff, i'm
>actually turning the nubus powermacs into a variant of apus for now. a
>lot of my fiddling actually ends up making some minor changes to the
>m68k code and calling that instead. 
>
>for now, i'm conveniently ignoring the dma stuff, but it looks like
>modifying the mac68k devices will actually prove to be more useful
>than dealing with the the standard pci powermac stuff. 

I think so too. And PCI powermac is still evolving, it would be more
difficult to take care of not breaking the NuBus support during evolutions.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
